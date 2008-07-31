require 'bluecloth'

module StaticMatic
  module TemplateHandlers
    class Markdown < ActionView::TemplateHandler
      def render(template, local_assigns = {})
        ::BlueCloth::new(template.source).to_html
      end
    end
  end
end

ActionView::Template.register_template_handler(:markdown, StaticMatic::TemplateHandlers::Markdown)