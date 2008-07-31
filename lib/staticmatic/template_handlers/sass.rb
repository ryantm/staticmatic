module StaticMatic::TemplateHandlers
  class Sass < ActionView::TemplateHandler
    def render(template)
      ::Sass::Engine.new(template.source, StaticMatic::Config[:sass_options]).render
    end
  end
end