module StaticMatic
  module TemplateHandlers
    class Sass < ActionView::TemplateHandler
      def render(template)
        ::Sass::Engine.new(template.source).render
      end
    end
  end
end