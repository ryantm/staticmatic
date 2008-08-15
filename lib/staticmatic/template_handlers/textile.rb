require 'redcloth'

class StaticMatic::TemplateHandlers::Textile < ActionView::TemplateHandler
  def render(template, local_assigns = {})
    ::RedCloth::new(template.source).to_html
  end
end

ActionView::Template.register_template_handler(:textile, StaticMatic::TemplateHandlers::Textile)