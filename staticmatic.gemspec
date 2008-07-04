require 'rubygems'

SPEC = Gem::Specification.new do |s|
  s.name = "staticmatic"
  s.version = "2.0.2"
  s.date = "2007-07-04"
  s.author = "Stephen Bartholomew"
  s.email = "steve@curve21.com"
  s.homepage = "http//www.staticmatic.net"
  s.summary = "Static sites, the Rails Way"
  s.files = Dir.glob("**/**/**/**/**")
  s.test_files =  Dir.glob("spec/*_spec.rb")
  s.add_dependency("haml", ">=2.0.1")
  s.add_dependency("mongrel")
  s.add_dependency("actionpack", ">=2.1.0")
  s.add_dependency("activesupport", ">=2.1.0")
  s.executables=['staticmatic']
end
