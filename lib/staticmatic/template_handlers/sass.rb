require 'sass'

module StaticMatic
  module TemplateHandlers
    class Sass < ActionView::TemplateHandler
      def render(template)
        ::Sass::Engine.new(template.source, StaticMatic::Config[:sass_options]).render
      end
    end
  end
end

ActionView::Template.register_template_handler(:sass, StaticMatic::TemplateHandlers::Sass)