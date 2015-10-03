module CassetteExplorer
  class Template < OpenStruct
    include ERB::Util

    def render(template_file)
      template = File.read template_file
      ERB.new(template).result(binding)
    end

    def page_path(file, page)
      "?file=#{u file}&url=#{u page.url}"
    end
  end
end
