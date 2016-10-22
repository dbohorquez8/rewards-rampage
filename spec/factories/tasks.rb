FactoryGirl.define do
  factory :task do
    description { Faker::Lorem.paragraph }
    points { Faker::Number.number(4) }
  end
end
