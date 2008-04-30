require File.dirname(__FILE__) + "/../lib/staticmatic"

describe "ActionView Helper Integration" do
  before(:all) do
    @sample_site_path = File.dirname(__FILE__) + "/fixtures/sample"
    
    @staticmatic = StaticMatic::Base.new(@sample_site_path)
  end
  
  it "should render partial" do
    @staticmatic.template.render(:partial => "pages/form").should == "This is a form\n"
  end
end