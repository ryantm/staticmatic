if defined? ActionView::Template and ActionView::Template.respond_to? :register_template_handler
  action_view_template = ActionView::Template
else
  action_view_template = ActionView::Base
end

{ "Haml"     => "haml",
  "Sass"     => "sass",
  "Markdown" => "bluecloth",
  "Textile"  => "redcloth",
  "Liquid"   => "liquid" }.each do |language, gem_name|
  begin
    require gem_name
    require 'staticmatic/template_handlers/' + language.downcase
    action_view_template.register_template_handler(language.downcase.to_sym, 
                                                   "StaticMatic::TemplateHandlers::#{language}".constantize)
  rescue
  end
end