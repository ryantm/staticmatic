require File.join(File.dirname(__FILE__), "..", "lib", "staticmatic")
require 'rubigen'
require 'rubigen/scripts/generate'

describe StaticMatic::Builder do
  def generate_site(path)
  end
  
  before :all do 
    source = RubiGen::PathSource.new(:application, File.join(File.dirname(__FILE__), "../app_generators"))
    RubiGen::Base.reset_sources
    RubiGen::Base.append_sources source
  end
  
  before :each do
    @root_dir    = File.dirname(__FILE__) + "/fixtures/builder-test"
    @staticmatic = StaticMatic::Base.new(@root_dir)
    
    @staticmatic.logger = mock("logger")
    @staticmatic.logger.should_receive(:info).at_least(:once)
    
    RubiGen::Scripts::Generate.new.run([@root_dir, "--quiet"], :generator => 'staticmatic')
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