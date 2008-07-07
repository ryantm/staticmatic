$LOAD_PATH.unshift "#{File.dirname(__FILE__)}/../vendor/html-scanner"
$LOAD_PATH.unshift File.dirname(__FILE__) unless
  $LOAD_PATH.include?(File.dirname(__FILE__)) ||
  $LOAD_PATH.include?(File.expand_path(File.dirname(__FILE__)))

require 'rubygems'
require 'active_support'
require 'action_view'
require 'haml'
require 'haml/template'
require 'sass'

require 'staticmatic/autoload'
require 'staticmatic/base'

ActionView::Base.class_eval do
  include StaticMatic::Helpers::AssetTagHelper
  include StaticMatic::Helpers::DeprecatedHelpers
  include StaticMatic::Helpers::PageHelper
  include StaticMatic::Helpers::UrlHelper
  include Mime
  include StaticMatic::Deprecation
end

# TODO: Replace with a correct template registration
Haml.init_rails(binding) # ActionView::Base.register_template_handler(:haml, Haml::Template)
if defined? ActionView::Template and ActionView::Template.respond_to? :register_template_handler
  action_view_template = ActionView::Template
else
  action_view_template = ActionView::Base
end

action_view_template.register_template_handler :sass, StaticMatic::TemplateHandlers::Sass
action_view_template.register_template_handler :markdown, StaticMatic::TemplateHandlers::Markdown
