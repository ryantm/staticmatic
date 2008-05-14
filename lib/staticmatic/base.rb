module StaticMatic
  class Base
    
    attr_accessor :logger
    attr_accessor :root_dir
    attr_accessor :build_dir
    attr_accessor :src_dir
    attr_accessor :template
    attr_accessor :request
    
    def initialize(root_dir)
      @root_dir = root_dir
      @src_dir = "#{@root_dir}/src"
      @build_dir = "#{@root_dir}/site"
      load_helpers
      initialize_logger
      initialize_template
    end
    
    # Create a logger to keep ActionView happy
    def initialize_logger
      @logger = Logger.new($stderr)
      @logger.level = Logger::INFO
      @logger
    end

    def initialize_template
      @template = ActionView::Base.new(@src_dir, {}, self)
      @template.template_format = :html
    end
    
    def render(template, options = {})
      @template.template_format = determine_format_for(template)
      template = strip_extension(template)

      begin
        @template.render_file(full_template_path(template), true)
      rescue Exception => e
        rescue_from_error(e)
      end
    end
    
    # Render the given template within the current layout
    def render_with_layout(template)
      content_for_layout = render(template)
      @template.instance_variable_set("@content_for_layout", content_for_layout)
      
      layout = @template.instance_variable_get("@layout")
      
      if !layout
        layout = determine_default_layout
      end
      
      render("layouts/#{layout}")
    end
    
    # Load all helpers from src/helpers/
    def load_helpers
      Dir["#{@src_dir}/helpers/**/*_helper.rb"].each do |helper|
        load helper
        module_name = File.basename(helper, '.rb').gsub(/(^|\_)./) { |c| c.upcase }.gsub(/\_/, '')
        ActionView::Base.class_eval("include #{module_name}")
      end
    end
    
    # Return the source directory for a given template
    #
    # Default is pages/
    #
    def template_directory_for(template)
      template_directory = "pages"
      
      ["stylesheets", "layouts"].each do |directory|
        if template.match(/^(\/)?#{directory}/)
          template_directory = ""
        end
      end
      
      template_directory
    end
    
    # Return the format for a given template path 
    #
    # For example: application.css.sass -> :css
    #
    def determine_format_for(template)
       
      ext_matches = template.match /\.([a-z0-9]+)/
      
      # For templates that have only handler extensions, default for backwards compatibility
      if ext_matches
        if !template.match(/\.([a-z0-9]+)\./)

          case ext_matches[1]
          when "sass"
            extension = :css
          when "haml"
            extension = :html
          end
        end
        
        extension = ext_matches[1].to_sym if !extension
      else
        extension = :html
      end
      
      extension
    end 
    
    def determine_default_layout
      layout = "site"
      Dir["#{@src_dir}/layouts/*"].each do |layout_file|
        if layout_file.match /\.application/
          layout = "application"
        end
      end
      layout 
    end
    
    # Remove the extension from a given template path
    def strip_extension(template)
      template.gsub(File.extname(template), '')
    end
    
    # Checks to see if a template exists within a given path 
    #
    # Current only used by the previewer as ActionView handles the actual checking
    def can_render?(template)
      @template.template_format = determine_format_for(template)
      template = strip_extension(template)
      @template.file_exists?(full_template_path(template))
    end
    
    # Adds 'index' to a given template path if the path is a directory
    # Will render as path/index.html
    #
    def add_index_if_needed(template)
      if File.directory? File.join(File.expand_path(@src_dir), template)
        File.join(template, "index")
      else
        template
      end
    end
    
    # Full path to a template, relative to src/
    def full_template_path(template)
      add_index_if_needed(File.join(template_directory_for(template), template))
    end
  end
end