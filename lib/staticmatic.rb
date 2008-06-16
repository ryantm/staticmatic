$:.unshift "#{File.dirname(__FILE__)}/../vendor/html-scanner"

lib_path = File.dirname(__FILE__)

require 'rubygems'
gem 'activesupport', '=2.0.2'
gem 'actionpack', '=2.0.2'
require 'active_support'
require 'action_view'
require 'haml'
require 'haml/template'
require 'sass'

["base", "config", "rescue", "template_handlers/sass", "deprecation", "actionpack_support/mime", "actionpack_support/remove_partial_benchmark"].each do |file|
  require "#{lib_path}/staticmatic/#{file}"
end

Dir["#{lib_path}/staticmatic/helpers/*_helper.rb","#{lib_path}/staticmatic/helpers/*_helpers.rb" ].each do |file|
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
  include StaticMatic::Deprecation
end

# TODO: Replace with a correct template registration
Haml.init_rails(binding) # ActionView::Base.register_template_handler(:haml, Haml::Template)

if defined? ActionView::Template and ActionView::Template.respond_to? :register_template_handler
  ActionView::Template
else
  ActionView::Base
end.register_template_handler :sass, StaticMatic::TemplateHandlers::Sass
