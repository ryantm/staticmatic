require 'liquid'

class StaticMatic::TemplateHandlers::Liquid < ActionView::TemplateHandler
  def render(template, local_assigns = {})
    ::Liquid::Template.parse(template.source).render(local_assigns)
  end
end

ActionView::Template.register_template_handler(:liquid, StaticMatic::TemplateHandlers::Liquid)