require File.dirname(__FILE__) + "/../staticmatic"

task :build do
  StaticMatic::Builder.build StaticMatic::Base.new(".")
end

task :preview do
  StaticMatic::Previewer.start StaticMatic::Base.new(".")
end