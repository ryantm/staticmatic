module StaticMatic
  module DeprecatedHelpers
    def stylesheets(*params)
      deprecate :alt => "stylesheet_link_tag"
      
      if params.size == 0
        
      end
      
      stylesheet_link_tag(*params)
    end
    
    def link(title, href = "", options = {})
      deprecate :alt => "link_to"
      link_to(title, href, options)
    end
    
    def img(name, options = {})
      deprecate :alt => "image_tag"
      image_tag(name, options)
    end
  end
end