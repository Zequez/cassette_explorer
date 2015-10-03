module CassetteExplorer
  class Page
    attr_reader :request

    def initialize(request)
      @request = request
    end

    def method
      @request['request']['method'].upcase
    end

    def status
      @request['response']['status']['code']
    end

    def title
      @title ||= html_raw.scan(/<title>([^<]+)<\/title>/).flatten.first
    end

    def html(relative_urls = false)
      if relative_urls
        html_with_relative_urls
      else
        html_raw
      end
    end

    def url
      @request['request']['uri']
    end

    def uri
      @uri ||= URI.parse(url)
    end

    def html_raw
      body = @request['response']['body']

      if body['base64_string']
        html = Base64.decode64 body['base64_string']
      else
        html = body['string']
      end
    end

    def html_with_relative_urls
      base_path = uri.scheme + '://' + uri.host + uri.path.sub(/[^\/]+$/, '')
      html_raw
        .gsub('href="./', "href=\"#{base_path}")
        .gsub('src="./', "src=\"#{base_path}")
    end
  end
end
