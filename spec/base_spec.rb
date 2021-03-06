require File.join(File.dirname(__FILE__), "..", "lib", "staticmatic")

describe StaticMatic::Base do
  before :all do
    @sample_site_path = File.dirname(__FILE__) + "/fixtures/sample"
    @staticmatic      = StaticMatic::Base.new(@sample_site_path)
  end

  it "should catch any haml template errors" do
    output = @staticmatic.render("page_with_error")
    output.should include("Illegal nesting")
  end
  
  it "should still render correctly after a haml error occured" do
    output = @staticmatic.render("page_with_error")
    @staticmatic.render("hello_world").should include("Hello world!")
  end
  
  it "should load custom helpers" do
    @staticmatic.template.respond_to?(:say).should be_true
  end
  
  it "should determine template directory for file" do
    @staticmatic.template_directory_for("stylesheets/site.css").should == ""
    @staticmatic.template_directory_for("hello_world.html").should == "pages"
    @staticmatic.template_directory_for("haml_test").should == "pages"    
  end
  
  it "should know if we can render a template or not" do
    @staticmatic.can_render?("hello_world.html").should_not be_false
    @staticmatic.can_render?("stylesheets/site.css").should_not be_false
  end
  
  it "should add index if needed" do
    @staticmatic.add_index_if_needed(@staticmatic.full_template_path("services")).should == "pages/services/index"
  end

  it "should know the relative path to the base dir" do 
    @staticmatic.calculate_relative_path_to_root("pages/services/web_development/costs").should == "../../"
    @staticmatic.calculate_relative_path_to_root("pages/services/web_development").should == "../"
  end
end