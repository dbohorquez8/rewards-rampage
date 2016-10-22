require 'rails_helper'

RSpec.describe Reward, type: :model do
  let(:reward) { FactoryGirl.build(:reward) }

  subject { reward }

  # Attributes
  it { should respond_to(:name) }
  it { should respond_to(:description) }
  it { should respond_to(:photo) }
  it { should respond_to(:points) }
  it { should respond_to(:reward_page_id) }

  # Required
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:points) }
  it { should validate_presence_of(:reward_page_id) }

  # Numericality validations
  it { should validate_numericality_of(:points) }

  # Associations
  it { should belong_to(:reward_page) }

  it { should be_valid }
end

RSpec.describe Reward, "methods" do
  describe "is_redeemed?" do
    it "returns true if status is redeemed" do
      reward = FactoryGirl.create(:reward, status: "redeemed")
      expect(reward.is_redeemed?).to be_truthy
    end

    it "returns true if participant_id is not nil" do
      reward = FactoryGirl.create(:reward, status: "", participant_id: 1)
      expect(reward.is_redeemed?).to be_truthy
    end
  end
end
