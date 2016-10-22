FactoryGirl.define do
  factory :task do
    description { FFaker::Lorem.paragraph }
    points { rand(1000).to_i }
  end
end
