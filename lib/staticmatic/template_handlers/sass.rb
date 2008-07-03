module StaticMatic::TemplateHandlers
  class Sass
    def initialize(view)
      @view = view
    end
  
    def render(template, local_assigns = {})
      template = template.source if template.respond_to? :source
      ::Sass::Engine.new(template, StaticMatic::Config[:sass_options]).render
    end
    
    def compilable?
      false
    end
  end
end