class WebService < ActiveRecord::Base
  validates :name, :url, :presence => true
  validates :name, :uniqueness => true
  validates :url, :format => URI::regexp(%w(http https))
end
