require 'mongrel'

module StaticMatic
  class Previewer < Mongrel::HttpHandler
    @@file_only_methods = %w(GET HEAD)
 
    def initialize(staticmatic)
      @files = Mongrel::DirHandler.new(staticmatic.build_dir, false)
      @staticmatic = staticmatic
    end
  
    def process(request, response)
      path_info = request.params[Mongrel::Const::PATH_INFO].chomp("/")
      get_or_head = @@file_only_methods.include? request.params[Mongrel::Const::REQUEST_METHOD]
      
      if get_or_head and @files.can_serve(path_info)
        @files.process(request, response) # try to serve static file from site dir
      elsif @staticmatic.can_render? path_info
        response.start(200) do |head, out|
          file_ext = File.extname(path_info).gsub(/^\./, '') 
          file_ext = "html" if file_ext.blank?

          file_name = path_info.chomp(".#{file_ext}")
          file_name = CGI::unescape(file_name)
          file_name.gsub!(/^\//, '')
        
          head["Content-Type"] = "text/#{file_ext}"
          output = ""
        
          @staticmatic.load_helpers
          output = (file_ext == "css") ?
            @staticmatic.render(path_info) :
            @staticmatic.render_with_layout(file_name)
          out.write output
        end
      end
    end
    
    class << self
      # Starts the StaticMatic preview server
      def start(staticmatic)
        staticmatic = StaticMatic::Base.new(staticmatic) if staticmatic.is_a? String

        config = Mongrel::Configurator.new :host => StaticMatic::Config[:host] do
          puts "Running Preview of #{staticmatic.root_dir} on port #{StaticMatic::Config[:port]}"
          listener :port => StaticMatic::Config[:port] do
            uri "/", :handler => Previewer.new(staticmatic)
            uri "/favicon", :handler => Mongrel::Error404Handler.new("")
          end
          trap("INT") { stop }
          run
        end
        config.join
      end
    end
  end
end