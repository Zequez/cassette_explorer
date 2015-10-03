module CassetteExplorer
  class Server
    def self.from_command_line(argv)
      options = {}

      parser = OptionParser.new do |opts|
        opts.banner = 'Usage: cassette_explorer /path/to/vcr/cassettes/directory [options]'

        opts.on('-r', '--no-replace-urls', 'Replace relative URLs with absolute URLs. Default: true') do |v|
          options[:relative_urls] = !v
        end

        opts.on(
          '-f',
          '--load-in-iframe',
          'Default the views to load in an iframe (it can be toggled from the page). Default: false'
        ) do |v|
          options[:load_in_iframe] = v
        end

        opts.on('-w', '--watch', 'Watches the cassettes for changes. Default: true') do |v|
          options[:watch] = v
        end

        opts.on('-p', '--port PORT', 'Port to mount the server') do |v|
          options[:port] = v
        end

        opts.on('-h', '--help', 'Prints this help') do |v|
          options[:help] = v
        end
      end

      begin
        parser.parse!(argv)
        raise OptionParser::InvalidOption if argv.size != 1
        options[:path] = argv.pop
      rescue OptionParser::InvalidOption
        options[:help] = true
      end

      if options[:help]
        puts parser.help
      else
        new options
      end
    end

    def initialize(options = {})
      @options = {
        port: 2332,
        path: './spec/fixtures/vcr_cassettes/',
        template: __dir__ + '/templates/index.erb',
        relative_urls: true,
        watch: true,
        load_in_iframe: false
      }.merge(options)

      @reader = Reader.new(@options[:path])
    end

    def run(blocking = true)
      @sections = @reader.read

      listener = Listen.to(@options[:path]) do
        puts 'Change detected, reloading cassettes'
        @sections = @reader.read
      end

      listener.start # doesn't block

      server = WEBrick::HTTPServer.new Port: @options[:port]
      server.mount_proc '/' do |req, res|
        url = req.query['url']
        file = req.query['file']
        data = req.query['data']

        if file and url
          section = @sections[file]
          page = section.detect{ |p| p.url == url }

          if data
            res.body = YAML::dump(page.request)
          else
            res.body = page.html(@options[:relative_urls])
          end
        else
          res.body = render_index(@sections)
        end
      end

      if blocking
        server.start
      else
        Thread.new do
          server.start
        end
      end
    end

    def render_index(data)
      Template.new(files: data, load_in_iframe: @options[:load_in_iframe]).render(@options[:template])
    end
  end
end
