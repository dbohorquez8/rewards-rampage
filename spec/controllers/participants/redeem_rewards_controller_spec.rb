require 'rails_helper'

RSpec.describe Participants::RedeemRewardsController, type: :controller do
  describe 'on POST to #create' do
    before(:each) do
      @reward_page = FactoryGirl.create(:reward_page)
      @participant = @reward_page.participants.create(FactoryGirl.attributes_for(:participant, points: 100))
      @reward      = @reward_page.rewards.create(FactoryGirl.attributes_for(:reward, points: 60))
    end

    it "should raise 404 if the participant is not found" do
      expect{
        process :create, method: :post, params: {participant_id: "222", reward_id: "ss"}
      }.to raise_error(ActiveRecord::RecordNotFound, /Couldn't find Participant/)
    end

    it "should raise 404 if the reward is not found" do
      expect{
        process :create, method: :post, params: {participant_id: @participant.identifier, reward_id: "ss"}
      }.to raise_error(ActiveRecord::RecordNotFound, /Couldn't find Reward/)
    end

    it "should mark the reward a redeemed" do
      process :create, method: :post, params: {participant_id: @participant.identifier, reward_id: @reward.id}, format: :js
      expect(@reward.reload.status).to eq('redeemed')
    end
  end
end
