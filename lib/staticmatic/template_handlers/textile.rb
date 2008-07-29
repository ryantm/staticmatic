module StaticMatic::TemplateHandlers
  class Textile < ActionView::TemplateHandler
    def render(template, local_assigns = {})
      template = template.source if template.respond_to? :source
      ::RedCloth::new( template ).to_html
    end
  end
end