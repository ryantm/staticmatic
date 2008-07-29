require File.join(File.dirname(__FILE__), "..", "lib", "staticmatic")

describe StaticMatic::Base do
  before(:all) do
    @sample_site_path = File.dirname(__FILE__) + "/fixtures/sample"
    @staticmatic      = StaticMatic::Base.new(@sample_site_path)
  end
  
  it "should render with layout" do
    output = @staticmatic.render_with_layout("hello_world.html")
    
    output.should include("My Sample Site")
    output.should include("Hello world!")
  end
  
  it "should render with layout specified in template" do
    output = @staticmatic.render_with_layout("specify_layout")
    output.should include("This is a Specified Layout")
  end
  
  it "should clean layout variable for next request" do
    output = @staticmatic.render_with_layout("specify_layout")
    @staticmatic.template.instance_variable_get("@layout").should be_nil
  end
end