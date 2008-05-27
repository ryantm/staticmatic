$:.unshift "#{File.dirname(__FILE__)}/../vendor/html-scanner"

lib_path = File.dirname(__FILE__)

require 'rubygems'
require 'active_support'
require 'actionpack'
require 'action_view'
require 'haml'
require 'sass'
require 'mongrel'

["base", "rescue", "previewer", "builder", "template_handlers/sass", "deprecation", "actionpack_support/mime"].each do |file|
  require "#{lib_path}/staticmatic/#{file}"
end

Dir["#{lib_path}/staticmatic/helpers/*"].each do |file|
  require file
  module_name = "StaticMatic::Helpers::" + file.match(/([a-z_]+)\.rb$/)[1].camelize
  ActionView::Base.class_eval { include module_name.constantize }
end

StaticMatic::Base.class_eval do 
  include StaticMatic::Rescue
  include StaticMatic::Deprecation
end

ActionView::Base.class_eval do
  include Mime
end



# TODO: Replace with a correct template registration
Haml.init_rails(binding) # ActionView::Base.register_template_handler(:haml, Haml::Template)

ActionView::Base.register_template_handler :sass, StaticMatic::TemplateHandlers::Sass

