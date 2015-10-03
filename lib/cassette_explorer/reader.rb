module CassetteExplorer
  class Reader
    def initialize(path)
      @path = File.expand_path(path)
    end

    def read

      files = Dir["#{@path}/**/**"]

      sections = {}

      files.reject{ |f| File.directory? f }.each do |file|
        section_name = section_name_from_file_path(file)
        sections[section_name] ||= []

        data = YAML.load_file(file)
        if data['http_interactions']
          data['http_interactions'].each do |request|
            sections[section_name].push Page.new(request)
          end
        end
      end

      sections
    end

    def section_name_from_file_path(file_path)
      file_path.gsub(@path, '')
    end
  end
end
