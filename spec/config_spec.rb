require File.dirname(__FILE__) + "/../lib/staticmatic"

describe StaticMatic::Config do
  it "should be able to get a configuration key" do
    StaticMatic::Config[:host].should == "0.0.0.0"
  end

  it "should be able to set a configuration key" do
    StaticMatic::Config[:bar] = "Hello"
    StaticMatic::Config[:bar].should == "Hello"
  end

  it "should be able to #delete a configuration key" do
    StaticMatic::Config[:bar] = "Hello"
    StaticMatic::Config[:bar].should == "Hello"
    StaticMatic::Config.delete(:bar)
    StaticMatic::Config[:bar].should == nil
  end

  it "should be able to #fetch a key that does exist" do
    StaticMatic::Config.fetch(:host, "192.168.2.1").should == "0.0.0.0"
  end

  it "should be able to #fetch a key that does exist" do
    StaticMatic::Config.fetch(:bar, "heylo").should == "heylo"
  end
end
