require 'haml'
require 'haml/engine'

class StaticMatic::TemplateHandlers::Haml < ActionView::TemplateHandler
  include ActionView::TemplateHandlers::Compilable

  def compile(template, local_assigns = {})
    options = StaticMatic::Config[:haml_options].dup
    options[:filename] = template.filename

    ::Haml::Engine.new(template.source, options).send(:precompiled_with_ambles, [])
  end
end

ActionView::Template.register_template_handler(:haml, StaticMatic::TemplateHandlers::Haml)