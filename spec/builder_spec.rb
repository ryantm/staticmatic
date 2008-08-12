require File.join(File.dirname(__FILE__), "..", "lib", "staticmatic")

describe StaticMatic::Builder do 
  before :each do
    @root_dir    = File.dirname(__FILE__) + "/fixtures/builder-test"
    @staticmatic = StaticMatic::Base.new(@root_dir)
    
    @staticmatic.logger = mock("logger")
    @staticmatic.logger.should_receive(:info).at_least(:once)
    
    # Replace with rubigen
    StaticMatic::Creator.setup(@root_dir)
    StaticMatic::Builder.build(@staticmatic)
  end
  
  after :each do
    FileUtils.rm_rf(@root_dir)
  end
  
  it "should create version tracking file with current build timestamp" do
    versions_file = "#{@root_dir}/builds"
    about_now     = Time.now.strftime("%Y%m%d%H%M")
    
    File.exists?(versions_file).should be_true

    versions = File.read(versions_file).split(/\n/)
    versions[0].should include(about_now)
  end
end