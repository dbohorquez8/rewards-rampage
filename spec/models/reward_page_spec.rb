require 'rails_helper'

RSpec.describe RewardPage, type: :model do
  it { should have_many(:tasks).dependent(:destroy) }
  it { should have_many(:participants).dependent(:destroy) }
  it { should have_many(:rewards).dependent(:destroy) }

  it { should validate_presence_of(:name) }

  it "should set the identifier on create if not set" do
    reward_page = RewardPage.new(name: "something")
    reward_page.save
    expect(reward_page).to be_valid
    expect(reward_page.identifier).not_to be_nil
  end

  it "should validate owner_email format" do
    reward_page = FactoryGirl.build(:reward_page, owner_email: "something")
    reward_page.valid?
    expect(reward_page.errors[:owner_email].size).to eq(1)
  end

  it "should allow nil value" do
    reward_page = FactoryGirl.build(:reward_page, owner_email: nil)
    reward_page.valid?
    expect(reward_page.errors[:owner_email].size).to eq(0)
  end

  it "should validate uniqueness of name" do
    reward_page = RewardPage.new(name: "something")
    reward_page.save
    expect(RewardPage.new(name: "something", identifier: reward_page.identifier).valid?).to be_falsey
  end
end
