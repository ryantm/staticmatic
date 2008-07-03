require File.join(File.dirname(__FILE__), "..", "lib", "staticmatic")

describe "Deprecation of old methods" do
  before(:all) do
    @sample_site_path = File.dirname(__FILE__) + "/fixtures/sample"
    @staticmatic = StaticMatic::Base.new(@sample_site_path)
    @staticmatic.logger = mock("logger") # Mock the logger
  end
  
  it "should display a message for deprecated methods" do 
    def deprecate_test
      @staticmatic.deprecate :alt => "another_method"
    end
    
    @staticmatic.logger.should_receive(:warn).with(/has been deprecated/)
    deprecate_test
  end
  
  it "should deprecate old helpers" do
    @staticmatic.template.logger.should_receive(:warn).with(/has been deprecated/)
    @staticmatic.template.link "Test"
  end
end