module StaticMatic::TemplateHandlers
  class Markdown
    def initialize(view)
      @view = view
    end
  
    def render(template, local_assigns = {})
      BlueCloth::new(template.source).to_html
    end
    
    def compilable?
      false
    end
  end
end