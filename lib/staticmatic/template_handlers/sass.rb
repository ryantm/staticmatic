module StaticMatic
  module TemplateHandlers
    class Sass < ActionView::TemplateHandler
      def render(template)
        # ActionView 2.1 compatibility
        template = template.source if template.respond_to? :source
        ::Sass::Engine.new(template, StaticMatic::Config[:sass_options]).render
      end
    end
  end
end