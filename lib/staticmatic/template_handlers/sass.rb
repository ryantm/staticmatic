module StaticMatic::TemplateHandlers
  class Sass
    def initialize(view)
      @view = view
    end
  
    def render(template, local_assigns)
      ::Sass::Engine.new(template, StaticMatic::Config[:sass_options]).render
    end
  end
end