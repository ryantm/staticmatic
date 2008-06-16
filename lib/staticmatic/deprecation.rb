module StaticMatic
  module Deprecation
    def deprecate(options = {})
      message = "#{caller_method_name} has been deprecated and will be removed."
      
      if options[:alt]
        message << %Q{ Please use "#{options[:alt]}" instead }
      end
      
      logger.warn(message)
    end
    
    private
    
    # Thanks to http://snippets.dzone.com/posts/show/2787 for this nugget
    def caller_method_name
      parse_caller(caller(2).first).last
    end

    def parse_caller(at)
      if /^(.+?):(\d+)(?::in `(.*)')?/ =~ at
        file = Regexp.last_match[1]
    		line = Regexp.last_match[2].to_i
    		method = Regexp.last_match[3]
    		[file, line, method]
    	end
    end
  end
end