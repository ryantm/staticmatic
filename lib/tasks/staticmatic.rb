require File.dirname(__FILE__) + "/../staticmatic"

task :build do
  require File.dirname(__FILE__) + "/../staticmatic/staticmatic/builder"
  StaticMatic::Builder.build StaticMatic::Base.new(".")
end

task :preview do
  require File.dirname(__FILE__) + "/../staticmatic/staticmatic/previewer"
  StaticMatic::Previewer.start StaticMatic::Base.new(".")
end