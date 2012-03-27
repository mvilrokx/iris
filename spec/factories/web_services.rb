# Read about factories at https://github.com/thoughtbot/factory_girl
require 'faker'

FactoryGirl.define do
  factory :web_service do |f|
    f.name { Faker::Name.name }
    f.url { Faker::Internet.url }
  end
end