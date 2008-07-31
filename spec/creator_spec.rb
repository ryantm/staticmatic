require File.join(File.dirname(__FILE__), "..", "lib", "staticmatic")

describe StaticMatic::Creator do
  before :each do
    @new_dir = File.dirname(__FILE__) + "/fixtures/creator-test"
    StaticMatic::Creator.setup(@new_dir)
  end
  
  after :each do
    FileUtils.rm_rf(@new_dir)
  end
  
  it "should create a directory" do
    File.exists?(@new_dir).should be_true
  end
  
  it "should copy default files into directory" do
    %w(build src Rakefile config.rb).each do |filename|
      File.exists?("#{@new_dir}/#{filename}").should be_true
    end
  end
end