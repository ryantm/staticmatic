require File.join(File.dirname(__FILE__), "..", "lib", "staticmatic")

# WIP: tested only be seeing that deprecation messages appear!
describe "Deprecation of old methods" do
  before(:all) do
    @sample_site_path = File.dirname(__FILE__) + "/fixtures/sample"
    @staticmatic = StaticMatic::Base.new(@sample_site_path)
  end
  
  it "should display a message for deprecated methods" do 
    def deprecate_test
      @staticmatic.deprecate :alt => "another_method"
    end
    
    deprecate_test
  end
  
  it "should deprecate old helpers" do
    @staticmatic.template.link "Test"
  end
end