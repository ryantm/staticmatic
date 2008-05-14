module StaticMatic
  module AssetTagHelper
    def stylesheet_link_tag(*sources)
      options = sources.extract_options!.stringify_keys
      expand_stylesheet_sources(sources).collect { |source| stylesheet_tag(source, options) }.join("\n")
    end
  
    def javascript_include_tag(*sources)
      options = sources.extract_options!.stringify_keys
      expand_javascript_sources(sources).collect { |source| javascript_src_tag(source, options) }.join("\n")
    end
      
    def compute_public_path(source, dir, ext = nil, include_host = true)
      path = "#{dir}/#{source}"
      path << ".#{ext}" if ext
      path
    end
  
  end
end