class StaticmaticGenerator < RubiGen::Base
  
  DEFAULT_SHEBANG = File.join(Config::CONFIG['bindir'],
                              Config::CONFIG['ruby_install_name'])

  default_options :template => nil

  attr_reader :name

  def initialize(runtime_args, runtime_options = {})
    super
    usage if args.empty?
    @destination_root = File.expand_path(args.shift)
    @name = base_name
    extract_options
  end

  def manifest
    record do |m|
      # Ensure appropriate folder(s) exists
      m.directory ''
      
      # Create stubs
      m.file_copy_each ["Rakefile"]
      BASEDIRS.each do |path|
        m.directory path
        m.folder path, path
      end

      # m.template "template.rb",  "some_file_after_erb.rb"
      # m.template_copy_each ["Rakefile"]
      # m.file     "file",         "some_file_copied"

      # Rubigen script/generate
      # m.dependency "install_rubigen_scripts", [destination_root, 'staticmatic'],
      #  :shebang => options[:shebang], :collision => :force
    end
  end

  protected
    def banner
      <<-EOS
Creates a scaffold for building a staticmatic website 
USAGE: #{spec.name} name

EOS
    end

    def add_options!(opts)
      opts.separator ''
      opts.separator 'Options:'
      # For each option below, place the default
      # at the top of the file next to "default_options"
      opts.on("-t", "--template=\"Your Template Directory\"", String,
              "Use a custom template for this project") { |options[:template]| }
      opts.on("-v", "--version", "Show the #{File.basename($0)} version number and quit.")
    end

    def extract_options
      # for each option, extract it into a local variable (and create an "attr_reader :author" at the top)
      # Templates can access these value via the attr_reader-generated methods, but not the
      # raw instance variable value.
      @source_root = File.expand_path(options[:template]) if options[:template]
    end

    # Installation skeleton.  Intermediate directories are automatically
    # created so don't sweat their absence here.
    BASEDIRS = %w(
      src/helpers
      src/layouts
      src/pages
      src/stylesheets
    )
end