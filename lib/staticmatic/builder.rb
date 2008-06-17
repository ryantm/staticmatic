module StaticMatic
  class Builder
    attr_accessor :staticmatic
    
    def initialize(staticmatic)
      @staticmatic = staticmatic
      
      build_pages
    end
    
    def build_pages
      ["pages", "stylesheets"].each do |template_path|
        Dir["#{@staticmatic.src_dir}/#{template_path}/**/*"].each do |path|
          if File.directory? path
            if !File.exists? build_path_for(path)
              puts "Creating: #{build_path_for(path)}"
              FileUtils.mkdir(build_path_for(path))
            end
          else

            format = @staticmatic.determine_format_for(path).to_s
            path = base_template_name_for(path)
            @staticmatic.template.template_format = format
            if should_overwrite?(path, format)
              if format == "html"
                output = @staticmatic.render_with_layout(path)
              else
                output = @staticmatic.render(path)
              end
                          
              output_prefix = "#{template_path}/" if template_path != "pages"
              save_built_file(path, output, format)
            end
          end
        end
      end
    end
    
    def should_overwrite?(path, format)

      build_file = "#{build_path_for(path)}.#{format}"

      path = @staticmatic.full_template_path(path)
      
      if File.exists? build_file

        template_path = @staticmatic.template.full_template_path(path, @staticmatic.template.pick_template_extension(path))
        #file_changed? template_path, build_file
        true
      else
        true
      end
    end
    
    def file_changed?(src_file, build_file)
      build_modification_time = File.stat(build_file).mtime.strftime("%Y%m%d%H%M%s")
      template_modification_time = File.stat(src_file).mtime.strftime("%Y%m%d%H%M%s")
      if template_modification_time > build_modification_time
        true
      else
        false
      end
    end
    
    # Strip off src file path and extension
    def base_template_name_for(path)
      path.gsub!(/^\.\/src\//, '')
      path.gsub!(/^pages\//, '') if path.match(/^pages/)
      path.gsub(/\.[a-z]+$/, '')
    end
    
    # Return an output filename
    def build_path_for(path)
      File.join(@staticmatic.build_dir, base_template_name_for(path))
    end
    
    # Save contents to the specified file with the given extension to the build directory
    def save_built_file(path, contents, extension)
      path = "#{build_path_for(path)}.#{extension}"
      puts "Generating #{path}"
      File.open(path, 'w+') do |f|
        f << contents
      end
    end
    
    class << self
      def build(staticmatic)
        staticmatic = StaticMatic::Base.new(staticmatic) if staticmatic.is_a? String
        new(staticmatic)
      end
    end
  end
end