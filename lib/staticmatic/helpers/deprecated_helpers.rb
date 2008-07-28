module StaticMatic
  module Helpers
    module DeprecatedHelpers
      def stylesheets(*params)
        deprecate :alt => "stylesheet_link_tag"

        if params.blank?
          glob = File.join(@staticmatic.src_dir, 'stylesheets', '*.sass')
          stylesheets = Dir[glob].inject([]) do |sum, stylesheet|
            sum << File.basename(stylesheet).chomp(File.extname(stylesheet))
          end
        
          stylesheets.concat assets_from_build_directory("stylesheets", "css", stylesheets)
        
          params = stylesheets
        end
      
        stylesheet_link_tag(params)
      end
    
      def link(title, href = "", options = {})
        deprecate :alt => "link_to"
        link_to(title, href, options)
      end
    
      def img(name, options = {})
        deprecate :alt => "image_tag"
        image_tag(name, options)
      end
    
      def javascripts(*files)
        javascript_include_tag(files)
      end
    
      private 
      # Return an array of asset files from a given build directory
      #
      # Optionally pass in an array to exclude files served dynamically
      def assets_from_build_directory(dir, ext, exclude = [])
        glob = File.join(@staticmatic.build_dir, dir, "*.#{ext}")
        Dir[glob].inject([]) do |sum, file|
          file = File.basename(file).chomp(File.extname(file))
          sum << file unless exclude && exclude.include?(file)
        end
      end
    end
  end
end