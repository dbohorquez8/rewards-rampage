require 'rails_helper'

RSpec.describe Participant, type: :model do
  before(:each) do
    @reward_page = FactoryGirl.create(:reward_page)
  end

  it { should belong_to(:reward_page) }

  it "should set the identifier on create if not set" do
    reward_page = FactoryGirl.create(:participant, reward_page_id: @reward_page.id)
    expect(reward_page).to be_valid
    expect(reward_page.identifier).not_to be_nil
  end

  it "should validate uniqueness of name" do
    reward_page = Participant.new(name: "something")
    reward_page.save
    expect(Participant.new(name: "something", identifier: reward_page.identifier).valid?).to be_falsey
  end
end
