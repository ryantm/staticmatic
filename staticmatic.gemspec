Gem::Specification.new do |s|
  s.name     = "staticmatic"
  s.version  = "2.1.1"
  s.date     = "2008-09-05"
  s.authors  = ["Stephen Bartholomew", "Thomas Reynolds"]
  s.email    = "tdreyno@gmail.com"
  s.homepage = "http://github.com/tdreyno/staticmatic"
  s.summary  = "Static sites, the Rails Way"
  s.files    = ["LICENSE",
                "Rakefile",
                "staticmatic.gemspec",
                "bin/staticmatic",
                "lib/staticmatic.rb",
                "lib/staticmatic/autoload.rb",
                "lib/staticmatic/base.rb",
                "lib/staticmatic/builder.rb",
                "lib/staticmatic/config.rb",
                "lib/staticmatic/deprecation.rb",
                "lib/staticmatic/previewer.rb",
                "lib/staticmatic/rescue.rb",
                "lib/staticmatic/actionpack_support/mime.rb",
                "lib/staticmatic/actionpack_support/remove_partial_benchmark.rb",
                "lib/staticmatic/helpers/asset_tag_helper.rb",
                "lib/staticmatic/helpers/page_helper.rb",
                "lib/staticmatic/helpers/url_helper.rb",
                "lib/staticmatic/template_handlers/haml.rb",
                "lib/staticmatic/template_handlers/liquid.rb",
                "lib/staticmatic/template_handlers/markdown.rb",
                "lib/staticmatic/template_handlers/sass.rb",
                "lib/staticmatic/template_handlers/textile.rb",
                "lib/staticmatic/templates/rescues/default_error.html.erb",
                "lib/staticmatic/templates/rescues/template_error.html.erb",
                "lib/templates/script/server",
                "lib/templates/script/builder",
                "lib/templates/src/helpers/site_helper.rb",
                "lib/templates/src/layouts/site.html.haml",
                "lib/templates/src/pages/index.html.haml",
                "lib/templates/src/stylesheets/site.css.sass",
                "vendor/html-scanner/html/document.rb",
                "vendor/html-scanner/html/node.rb",
                "vendor/html-scanner/html/sanitizer.rb",
                "vendor/html-scanner/html/selector.rb",
                "vendor/html-scanner/html/tokenizer.rb",
                "vendor/html-scanner/html/version.rb"]
  s.executables = %w(staticmatic)
  s.add_dependency("templater")
  s.add_dependency("mongrel")
  s.add_dependency("haml",          ">=2.0.1")
  s.add_dependency("actionpack",    ">=2.1.0")
  s.add_dependency("activesupport", ">=2.1.0")
end