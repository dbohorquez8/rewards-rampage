FactoryGirl.define do
  factory :participant do
    name  { FFaker::Name.name }
    email { FFaker::Internet.email }
  end
end
