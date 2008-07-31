Gem::Specification.new do |s|
  s.name        = "staticmatic"
  s.version     = "2.0.3"
  s.date        = "2008-07-31"
  s.authors     = ["Stephen Bartholomew", "Thomas Reynolds"]
  s.email       = "steve@curve21.com"
  s.homepage    = "http://github.com/tdreyno/staticmatic"
  s.summary     = "Static sites, the Rails Way"
  s.files       = ["LICENSE",
                   "Rakefile",
                   "staticmatic.gemspec",
                   "bin/staticmatic",
                   "lib/staticmatic.rb",
                   "lib/staticmatic/autoload.rb",
                   "lib/staticmatic/base.rb",
                   "lib/staticmatic/builder.rb",
                   "lib/staticmatic/config.rb",
                   "lib/staticmatic/creator.rb",
                   "lib/staticmatic/deprecation.rb",
                   "lib/staticmatic/previewer.rb",
                   "lib/staticmatic/rescue.rb",
                   "lib/staticmatic/actionpack_support/mime.rb",
                   "lib/staticmatic/actionpack_support/remove_partial_benchmark.rb",
                   "lib/staticmatic/helpers/asset_tag_helper.rb",
                   "lib/staticmatic/helpers/deprecated_helpers.rb",
                   "lib/staticmatic/helpers/page_helper.rb",
                   "lib/staticmatic/helpers/url_helper.rb",
                   "lib/staticmatic/template_handlers/haml.rb",
                   "lib/staticmatic/template_handlers/liquid.rb",
                   "lib/staticmatic/template_handlers/markdown.rb",
                   "lib/staticmatic/template_handlers/sass.rb",
                   "lib/staticmatic/template_handlers/textile.rb",
                   "lib/staticmatic/templates/default/Rakefile",
                   "lib/staticmatic/templates/default/config.rb",
                   "lib/staticmatic/templates/default/src/helpers/site_helper.rb",
                   "lib/staticmatic/templates/default/src/layouts/site.html.haml",
                   "lib/staticmatic/templates/default/src/pages/index.html.haml",
                   "lib/staticmatic/templates/default/src/stylesheets/site.css.sass",
                   "lib/staticmatic/templates/rescues/default_error.html.erb",
                   "lib/staticmatic/templates/rescues/template_error.html.erb",
                   "lib/tasks/staticmatic.rb",
                   "vendor/html-scanner/html/document.rb",
                   "vendor/html-scanner/html/node.rb",
                   "vendor/html-scanner/html/sanitizer.rb",
                   "vendor/html-scanner/html/selector.rb",
                   "vendor/html-scanner/html/tokenizer.rb",
                   "vendor/html-scanner/html/version.rb"]
  s.executables = %w(staticmatic)
  s.add_dependency("haml", ">=2.0.1")
  s.add_dependency("mongrel")
  s.add_dependency("actionpack", ">=2.1.0")
  s.add_dependency("activesupport", ">=2.1.0")
end
