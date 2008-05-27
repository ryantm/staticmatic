module StaticMatic
  module Helpers
    module DeprecatedHelpers
      def stylesheets(*params)
        deprecate :alt => "stylesheet_link_tag"

        if params.blank?
          stylesheets = []
          Dir[File.join(@staticmatic.src_dir, 'stylesheets', '*.sass')].each do |stylesheet|
            stylesheet = File.basename(stylesheet).chomp(File.extname(stylesheet))
            stylesheets << stylesheet
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
        files = []
        Dir[File.join(@staticmatic.build_dir, dir, "*.#{ext}")].each do |file|
          file = File.basename(file).chomp(File.extname(file))
          if !exclude || !exclude.include?(file)
            files << file
          end
        end
      
        files
      end
    end
  end
end