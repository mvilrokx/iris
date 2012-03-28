require 'spec_helper'

describe "Home" do
  describe "GET /" do
    it "Shows the home page" do
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      visit root_path
      page.should have_content 'Iris'
      # response.status.should be(200)
    end
  end
end
