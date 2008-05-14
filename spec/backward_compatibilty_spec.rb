require File.dirname(__FILE__) + "/../lib/staticmatic"

describe "Backward compatibility for existing sites" do
  before(:all) do
    @sample_site_path = File.dirname(__FILE__) + "/fixtures/old-style-sample"
    @staticmatic = StaticMatic::Base.new(@sample_site_path)
  end
  
  it "should use application.haml as default layout if found" do
    @staticmatic.determine_default_layout.should == "application"
  end
end