module StaticMatic
  module Helpers
    module AssetTagHelper
      def stylesheet_link_tag(*sources)
        options = sources.extract_options!.stringify_keys
        options[:prefix] = relative_path_to_root
        expand_stylesheet_sources(sources).collect do |source| 
          stylesheet_tag(source, options) 
        end.join("\n")
      end
  
      def javascript_include_tag(*sources)
        options = sources.extract_options!.stringify_keys
        options[:prefix] = relative_path_to_root
        expand_javascript_sources(sources).collect do |source|  
          javascript_src_tag(source, options)
        end.join("\n")
      end
      
      def javascript_src_tag(source, options)
        content_tag("script", "", { "type" => Mime::JS, "src" => "#{options[:prefix]}javascipts/#{source}.js" }.merge(options))
      end

      def stylesheet_tag(source, options)
        tag("link", { "rel" => "stylesheet", "type" => Mime::CSS, "media" => "screen", "href" => "#{options[:prefix]}stylesheets/#{source}.css" }.merge(options), false, false)
      end
      
      def compute_public_path(source, dir, ext = nil, include_host = true)
        path = "#{dir}/#{source}"
        path << ".#{ext}" if ext
        path
      end
  
      def relative_path_to_root(current_path = nil)
        @staticmatic.relative_path_to_root(current_path)
      end
    end
  end
end