module StaticMatic
  module Rescue
    # Render an error template for the given exception
    def rescue_from_error(exception)
      rescue_template = (exception == ActionView::TemplateError) ?
        "template_error" :
        "default_error"
      
      error_template_path = File.expand_path(File.dirname(__FILE__) + "/templates/rescues/#{rescue_template}.html.erb")
      @template.instance_variable_set("@exception", exception)
      @template.render_file(error_template_path, false)
    end
  end
end