require File.join(File.dirname(__FILE__), "..", "staticmatic")

task :build do
  StaticMatic::Builder.build(".")
end

task :preview do
  StaticMatic::Previewer.start(".")
end