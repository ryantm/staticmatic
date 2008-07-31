require File.join(File.dirname(__FILE__), "..", "lib", "staticmatic")

describe StaticMatic::Base do
  before :all do
    @sample_site_path = File.dirname(__FILE__) + "/fixtures/sample"
    @staticmatic      = StaticMatic::Base.new(@sample_site_path)
  end
  
  it "should render a single template" do
    @staticmatic.render("hello_world").should include("Hello world!")
  end
  
  it "should render a page" do
    @staticmatic.render("hello_world").should include("Hello world!")
  end
  
  it "should render with layout" do
    output = @staticmatic.render_with_layout("hello_world.html")
    
    output.should include("My Sample Site")
    output.should include("Hello world!")
  end
  
  it "should render haml template" do
    output = @staticmatic.render("haml_test")
    output.should include("<strong>Hello from haml</strong>")
  end

  if ActionView::Template.template_handler_extensions.include? :markdown
    it "should render markdown template" do
      output = @staticmatic.render("markdown_test")
      output.should match(/<strong>Hello from markdown<\/strong>/)
    end
  end
  
  if ActionView::Template.template_handler_extensions.include? :textile
    it "should render textile template" do
      output = @staticmatic.render("textile_test")
      output.should match(/<strong>Hello from textile<\/strong>/)
    end
  end
  
  if ActionView::Template.template_handler_extensions.include? :liquid
    it "should render liquid template" do
      output = @staticmatic.render("liquid_test")
      output.should match(/<strong>Hello from liquid<\/strong>/)
    end
  end
  
  it "should register a css renderer" do
    output = @staticmatic.render("stylesheets/site.css")
    output.should include("body {")
    output.should include("font-family: verdana")
  end
  
  it "should setup up css type correctly" do
    @staticmatic.determine_format_for("stylesheets/site.css").should == :css
  end
  
  it "should determine format for file with extension" do
    @staticmatic.determine_format_for("stylesheets/site.css.sass").should == :css
  end
  
  it "should have sensible defaults for haml & sass" do
    @staticmatic.determine_format_for("stylesheets/site.sass").should == :css
    @staticmatic.determine_format_for("pages/test.haml").should == :html
  end
  
  it "should render index template from sub-directory" do
    output = @staticmatic.render("services/")
    output.should include("Services")
  end
  
  it "should render template from sub-directory" do
    output = @staticmatic.render("services/web_development")
    output.should include("Web Development")
  end
  
  it "should render with layout specified in template" do
    output = @staticmatic.render_with_layout("specify_layout")
    output.should include("This is a Specified Layout")
  end
end