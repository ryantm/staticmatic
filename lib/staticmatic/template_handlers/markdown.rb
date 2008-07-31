module StaticMatic::TemplateHandlers
  class Markdown < ActionView::TemplateHandler
    def render(template, local_assigns = {})
      ::BlueCloth::new(template.source).to_html
    end
  end
end