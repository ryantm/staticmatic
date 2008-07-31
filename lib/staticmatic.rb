$LOAD_PATH.unshift "#{File.dirname(__FILE__)}/../vendor/html-scanner"
$LOAD_PATH.unshift File.dirname(__FILE__) unless
  $LOAD_PATH.include?(File.dirname(__FILE__)) ||
  $LOAD_PATH.include?(File.expand_path(File.dirname(__FILE__)))

require 'rubygems'
require 'active_support'
require 'action_view'
require 'staticmatic/autoload'
require 'staticmatic/base'
require 'staticmatic/template_handlers'

ActionView::Base.class_eval do
  include StaticMatic::Helpers::AssetTagHelper
  include StaticMatic::Helpers::DeprecatedHelpers
  include StaticMatic::Helpers::PageHelper
  include StaticMatic::Helpers::UrlHelper
  include Mime
  include StaticMatic::Deprecation
end