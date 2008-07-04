module StaticMatic::TemplateHandlers
  class Markdown
    def initialize(view)
      @view = view
    end
  
    def render(template, local_assigns = {})
      template = template.source if template.respond_to? :source
      BlueCloth::new( template ).to_html
    end
    
    def compilable?
      false
    end
  end
end