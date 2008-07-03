module StaticMatic
  class Base
    include StaticMatic::Rescue
    include StaticMatic::Deprecation
    
    attr_accessor :logger
    attr_accessor :root_dir
    attr_accessor :build_dir
    attr_accessor :src_dir
    attr_accessor :template
    attr_accessor :request
    
    def initialize(root_dir)
      @root_dir = root_dir
      @src_dir = "#{@root_dir}/src"
      @build_dir = "#{@root_dir}/build"
      load_helpers
      initialize_config
      initialize_logger
      initialize_template
    end
    
    def initialize_config
      StaticMatic::Config.setup
      config_file = File.join(@root_dir, "config.rb")
      
      if File.exists? config_file
        require config_file 
      end
      
      if defined?(Haml::Template)
        Haml::Template.options = StaticMatic::Config[:haml_options]
      end
    end
    
    def initialize_logger
      @logger = Logger.new($stderr)
      @logger.level = Logger::INFO
      @logger
    end

    def initialize_template
      @template = ActionView::Base.new([], {}, self)
      @template.template_format = :html
      finder.view_paths = [@src_dir]
      @template.instance_variable_set("@staticmatic", self)
    end
    
    # Work around actionpack API changes
    def finder
      if @template.respond_to? :finder
        @template.finder
      else
        @template
      end
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
      @template.instance_variable_set("@relative_path_to_root", "#{calculate_relative_path_to_root(full_template_path(template))}")
      content_for_layout = render(template)
      
      @template.instance_variable_set("@current_page", template)
      @template.instance_variable_set("@content_for_layout", content_for_layout)
      
      layout = @template.instance_variable_get("@layout")
      
      # Clean @layout variable for next request
      @template.instance_variable_set("@layout", nil)
      
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
    
    # Default layout is 'site' but we'll also accept 'application'
    def determine_default_layout
      layout = "site"
      
      Dir["#{@src_dir}/layouts/**"].each do |layout_file|

        if layout_file.match /application/
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
      finder.file_exists?(full_template_path(template))
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
    
    def calculate_relative_path_to_root(template)
      if template.match(/^((\.\.?)?\/|\#|.+?\:)/) == nil
        current_page_depth = template.split('/').length - 2;
        (current_page_depth > 0) ? ([ '..' ] * current_page_depth).join('/') + '/' : ''
      else
        ''
      end
    end    
  end
end