module StaticMatic
  module Helpers
    module UrlHelper
      def link_to(name, options = {}, html_options = nil)
        options = urlify(name) if options == {}
        super(name, options, html_options)
      end
    
      def urlify(string)
        string.tr(" ", "_").
               sub("&", "and").
               sub("@", "at").
               tr("^A-Za-z0-9_", "").
               sub(/_{2,}/, "_").
               downcase
      end
    end
  end
end