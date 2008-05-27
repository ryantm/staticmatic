module StaticMatic
  module Helpers
    module AssetTagHelper
      def stylesheet_link_tag(*sources)
        options = sources.extract_options!.stringify_keys
        expand_stylesheet_sources(sources).collect do |source| 
          stylesheet_tag(source, options) 
        end.join("\n")
      end
  
      def javascript_include_tag(*sources)
        options = sources.extract_options!.stringify_keys
        expand_javascript_sources(sources).collect do |source|  
          javascript_src_tag(source, options)
        end.join("\n")
      end
      
      def javascript_src_tag(source, options)
        content_tag("script", "", { "type" => Mime::JS, "src" => compute_public_path(source, "javascripts", "js") }.merge(options))
      end

      def stylesheet_tag(source, options)
        tag("link", { "rel" => "stylesheet", "type" => Mime::CSS, "media" => "screen", "href" => compute_public_path(source, "stylesheets", "css") }.merge(options), false, false)
      end
      
      def compute_public_path(source, dir, ext = nil, include_host = true)
        path = "#{relative_path_to_root}#{dir}/#{source}"
        path << ".#{ext}" if ext
        path
      end
  
      def relative_path_to_root
        @relative_path_to_root
      end
    end
  end
end