$:.unshift "#{File.dirname(__FILE__)}/../vendor/html-scanner"
require 'rubygems'
require 'active_support'
require 'actionpack'
require 'action_view'
require 'haml'
require 'sass'
require 'mongrel'

["base", "rescue", "previewer", "builder", "template_handlers/sass", "deprecation", "helpers/deprecated_helpers", "helpers/asset_tag_helper", "helpers/page_helper", "helpers/url_helper"].each do |file|
  require File.dirname(__FILE__) + "/staticmatic/#{file}"
end

StaticMatic::Base.class_eval do 
  include StaticMatic::Rescue
  include StaticMatic::Deprecation
end

ActionView::Base.class_eval do
  include StaticMatic::DeprecatedHelpers
  include StaticMatic::Deprecation
  include StaticMatic::AssetTagHelper  
  include StaticMatic::PageHelper  
  include StaticMatic::UrlHelper
end

# TODO: Replace with a correct template registration
Haml.init_rails(binding) # ActionView::Base.register_template_handler(:haml, Haml::Template)

ActionView::Base.register_template_handler :sass, StaticMatic::TemplateHandlers::Sass

