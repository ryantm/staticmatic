require File.dirname(__FILE__) + "/../lib/staticmatic"

describe StaticMatic::Base do
  before(:all) do
    @sample_site_path = File.dirname(__FILE__) + "/fixtures/sample"
    
    @staticmatic = StaticMatic::Base.new(@sample_site_path)
  end

  it "should catch any template errors" do
    output = @staticmatic.render("page_with_error")
    output.match(/Illegal Indentation/)
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
    @staticmatic.can_render?("hello_world.html").should be_true
    @staticmatic.can_render?("stylesheets/site.css").should be_true
  end
  
  it "should add index if needed" do
    @staticmatic.add_index_if_needed(@staticmatic.full_template_path("services")).should == "pages/services/index"
  end
  
  it "should determine layout based on existing file" do
    @staticmatic.determine_default_layout.should == "site"
  end
end