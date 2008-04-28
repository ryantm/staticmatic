module StaticMatic
  module TemplateHandlers
    class Sass
      def initialize(view)
        @view = view
      end
    
      def render(template, local_assigns)
        ::Sass::Engine.new(template).render
      end
    end
  end
end