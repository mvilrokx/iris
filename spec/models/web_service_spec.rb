require 'spec_helper'

describe WebService do
  it "has a valid factory" do
    FactoryGirl.create(:web_service).should be_valid
  end
  it "is invalid without a name" do
    FactoryGirl.build(:web_service, name: nil).should_not be_valid
  end
  it "is invalid without a URL" do
    FactoryGirl.build(:web_service, url: nil).should_not be_valid
  end
  it "has an invalid URL" do
    FactoryGirl.build(:web_service, url: 'ftp://test.com').should_not be_valid
  end
  it "has an valid URL" do
    FactoryGirl.build(:web_service, url: 'http://test.com').should be_valid
  end
end
