{ "Haml"     => "haml",
  "Sass"     => "sass",
  "Markdown" => "bluecloth",
  "Textile"  => "redcloth",
  "Liquid"   => "liquid" }.each do |language, gem_name|
  begin
    require gem_name
    require 'staticmatic/template_handlers/' + language.downcase
    ActionView::Template.register_template_handler(language.downcase.to_sym, 
                                                   "StaticMatic::TemplateHandlers::#{language}".constantize)
  rescue
    # Could not load gem or handler
  end
end