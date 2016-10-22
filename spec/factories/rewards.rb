FactoryGirl.define do
  factory :reward do
    name 		{ FFaker::Product.product_name }
    description { FFaker::Lorem.sentence(5) }
    photo		{ File.new(Rails.root.join('spec', 'fixtures', 'files', 'mia.jpg')) }
    points		{ rand(1000).to_i }
    reward_page
  end
end
