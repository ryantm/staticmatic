require 'redcloth'

module StaticMatic
  module TemplateHandlers
    class Textile < ActionView::TemplateHandler
      def render(template, local_assigns = {})
        ::RedCloth::new(template.source).to_html
      end
    end
  end
end

ActionView::Template.register_template_handler(:textile, StaticMatic::TemplateHandlers::Textile)