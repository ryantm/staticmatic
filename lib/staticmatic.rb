$LOAD_PATH.unshift "#{File.dirname(__FILE__)}/../vendor/html-scanner"
$LOAD_PATH.unshift File.dirname(__FILE__) unless
  $LOAD_PATH.include?(File.dirname(__FILE__)) ||
  $LOAD_PATH.include?(File.expand_path(File.dirname(__FILE__)))

require 'rubygems'
require 'active_support'
require 'action_view'
require 'staticmatic/autoload'
require 'staticmatic/base'

# Load template handlers
Dir[File.dirname(__FILE__) + '/staticmatic/template_handlers/*.rb'].each do |handler|
  begin
    require "staticmatic/template_handlers/#{File.basename(handler)}"
  rescue
    # Could not load gem or handler
  end
end

ActionView::Base.class_eval do
  include StaticMatic::Helpers::AssetTagHelper
  include StaticMatic::Helpers::PageHelper
  include StaticMatic::Helpers::UrlHelper
  include StaticMatic::Deprecation
  include Mime
end