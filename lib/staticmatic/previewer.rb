require 'mongrel'

module StaticMatic
  class Previewer < Mongrel::HttpHandler
    @@file_only_methods = %w(GET HEAD)
 
    def initialize(staticmatic)
      @files = Mongrel::DirHandler.new(staticmatic.build_dir, false)
      @staticmatic = staticmatic
    end
  
    def process(request, response)
      @staticmatic.load_helpers
      path_info = request.params[Mongrel::Const::PATH_INFO]
      get_or_head = @@file_only_methods.include? request.params[Mongrel::Const::REQUEST_METHOD]
      
      file_ext = File.extname(path_info).gsub(/^\./, '') 
      file_ext = "html" if file_ext.blank?
      
      file_name = path_info.chomp(".#{file_ext}")
      file_name = CGI::unescape(file_name)
      file_name.gsub!(/^\//, '')

      if file_ext && file_ext.match(/html|css/)
        response.start(200) do |head, out|
          head["Content-Type"] = "text/#{file_ext}"
          output = ""
          
          if @staticmatic.can_render? path_info
            output = (file_ext == "css") ?
              @staticmatic.render(path_info) :
              @staticmatic.render_with_layout(file_name)
          else
            if @files.can_serve(path_info)
              @files.process(request,response)
            else
              output = "File not Found"
            end
          end
          out.write output
        end
      else
        # try to serve static file from site dir
        @files.process(request,response) if @files.can_serve(path_info)
      end
    end
    
    class << self
      # Starts the StaticMatic preview server
      def start(staticmatic)
        staticmatic = StaticMatic::Base.new(staticmatic) if staticmatic.is_a? String

        config = Mongrel::Configurator.new :host => StaticMatic::Config[:host] do
          puts "Running Preview of #{staticmatic.root_dir} on port #{StaticMatic::Config[:post]}"
          listener :port => StaticMatic::Config[:port] do
            uri "/", :handler => Previewer.new(staticmatic)
          end
          trap("INT") { stop }
          run
        end
        config.join
      end
    end
  end
end
