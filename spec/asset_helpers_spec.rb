require File.join(File.dirname(__FILE__), "..", "lib", "staticmatic")

describe "Asset Helpers" do
  ActionView::Base.included_modules.each do |mod|
    include mod if mod.parents.include?(ActionView::Helpers)
  end
  
  include StaticMatic::Helpers::AssetTagHelper
  before(:all) do
    @sample_site_path = File.dirname(__FILE__) + "/fixtures/sample"
    @staticmatic = StaticMatic::Base.new(@sample_site_path)
  end
  
  it "should render partial" do
    @staticmatic.template.render(:partial => "pages/form").should == "This is a form\n"
  end
  
  it "should generate stylesheet link" do
    @relative_path_to_root = @staticmatic.calculate_relative_path_to_root('pages/services/web_development/costs')
    output = stylesheet_link_tag("site")
    expected = "../../stylesheets/site.css"
    output.should match(/#{expected}/)
  end
end