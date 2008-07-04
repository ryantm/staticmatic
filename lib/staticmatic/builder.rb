module StaticMatic
  class Builder
    attr_accessor :staticmatic
    
    def initialize(staticmatic)
      @staticmatic = staticmatic

      determine_last_build if StaticMatic::Config[:use_build_tracking]

      build_pages

      log_version if StaticMatic::Config[:use_build_tracking]
    end
    
    def determine_last_build
      versions_file = @staticmatic.root_dir + "/builds"
      
      if File.exists?(versions_file)
        @last_build = File.read(versions_file).split(/\n/)[0]
      else
        @last_build = ""
      end
    end
    
    def log_version
      timestamp = Time.now.strftime("%Y%m%d%H%M%S")
      versions_file = @staticmatic.root_dir + "/builds"
      
      if File.exists?(versions_file)
        current_versions = File.read(versions_file)
        
        File.open(versions_file, "w") do |file|
          file.puts timestamp
          file.puts current_versions
        end
      else
        File.open(versions_file, "w") do |file|
          file.puts timestamp
        end
      end
      
    end
    
    def build_pages
      ["pages", "stylesheets"].each do |template_path|
        Dir["#{@staticmatic.src_dir}/#{template_path}/**/*"].each do |path|

          if File.directory? path
            if !File.exists? build_path_for(path)
              @staticmatic.logger.info("Creating: #{build_path_for(path)}")
              
              FileUtils.mkdir(build_path_for(path))
            end
          else

            format = @staticmatic.determine_format_for(path).to_s
            base_template_name = base_template_name_for(path)

            @staticmatic.template.template_format = format
            build_file_path = "#{build_path_for(path)}"

            if !StaticMatic::Config[:use_build_tracking] || (StaticMatic::Config[:use_build_tracking] && should_overwrite?(path, build_file_path))
              if format == "html"
                output = @staticmatic.render_with_layout(base_template_name)
              else
                output = @staticmatic.render(base_template_name)
              end
                          
              output_prefix = "#{template_path}/" if template_path != "pages"
              save_built_file(build_file_path, output)
            end
          end
        end
      end
    end
    
    def should_overwrite?(template_file, build_file)

      if File.exists? build_file
        file_changed? template_file
      else
        true
      end
    end
    
    def file_changed?(src_file)
      template_modification_time = File.stat(src_file).mtime.strftime("%Y%m%d%H%M%S")

      if template_modification_time.to_i > @last_build.to_i
        true
      else
        false
      end
    end
    
    # Strip off src file path and extension
    def base_template_name_for(path)
      
      path.gsub("#{@staticmatic.root_dir}/", "").
           gsub(/^src\//, '').
           gsub(/^pages\//, '').
           gsub(/\.[a-z]+$/, '')
    end
    
    # Return an output filename
    def build_path_for(path)
      File.join(@staticmatic.build_dir, base_template_name_for(path))
    end
    
    # Save contents to the specified file with the given extension to the build directory
    def save_built_file(path, contents)

      @staticmatic.logger.info("Generating #{path}")
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