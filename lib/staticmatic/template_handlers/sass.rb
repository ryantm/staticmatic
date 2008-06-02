module StaticMatic
  module TemplateHandlers
    class Sass < ActionView::TemplateHandler
      def render(template)
        ::Sass::Engine.new(template).render
      end
    end
  end
end