module StaticMatic::TemplateHandlers
  class Markdown < ActionView::TemplateHandler
    def render(template, local_assigns = {})
      template = template.source if template.respond_to? :source
      ::BlueCloth::new(template).to_html
    end
  end
end