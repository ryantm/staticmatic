require 'liquid'

module StaticMatic
  module TemplateHandlers
    class Liquid < ActionView::TemplateHandler
      def render(template, local_assigns = {})
        ::Liquid::Template.parse(template.source).render(local_assigns)
      end
    end
  end
end

ActionView::Template.register_template_handler(:liquid, StaticMatic::TemplateHandlers::Liquid)