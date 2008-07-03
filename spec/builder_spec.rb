require File.join(File.dirname(__FILE__), "..", "lib", "staticmatic")

describe StaticMatic::Builder do 
  before(:all) do
    @root_dir = File.dirname(__FILE__) + "/fixtures/test"
    @staticmatic = StaticMatic::Base.new(@root_dir)
    @staticmatic.logger = mock("logger")
    @staticmatic.logger.should_receive(:info).at_least(:once)
    
    StaticMatic::Creator.setup(@root_dir)
    StaticMatic::Builder.build(@staticmatic)
  end
  
  after(:all) do
    FileUtils.rm_rf(@root_dir)
  end
  
  it "should create version tracking file with current build timestamp" do
    versions_file = "#{@root_dir}/builds"
    about_now = Time.now.strftime("%Y%m%d%H%M")
    
    File.exists?(versions_file).should be_true

    versions = File.read(versions_file).split(/\n/)
    versions[0].should match(/#{about_now}/)
  end
end