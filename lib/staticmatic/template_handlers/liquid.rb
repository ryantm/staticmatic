gem 'liquid'
autoload :Liquid, 'liquid'

module StaticMatic::TemplateHandlers
  class Liquid < ActionView::TemplateHandler
    def render(template, local_assigns = {})
      ::Liquid::Template.parse(template.source).render(local_assigns)
    end
  end
end