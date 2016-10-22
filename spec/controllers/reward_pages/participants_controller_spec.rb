require 'rails_helper'

RSpec.describe RewardPages::ParticipantsController, type: :controller do
  describe "POST #create" do
    before(:each) do
      @reward_page = FactoryGirl.create(:reward_page)
      @participant_params = FactoryGirl.attributes_for(:participant)
    end

    context "with correct params" do
      it "should create a participant" do
        expect{
          post :create, params: {reward_page_id: @reward_page.identifier, participant: @participant_params}
        }.to change(Participant, :count).by(1)
      end

      it "should redirect to the rewards page" do
        post :create, params: {reward_page_id: @reward_page.identifier, participant: @participant_params}
        expect(response).to redirect_to(reward_page_path(@reward_page.identifier))
      end
    end

    context "with incorret params" do
      it "should not create the participant" do
        expect{
          post :create, params: {reward_page_id: @reward_page.identifier, participant: {name: ""}}
        }.to change(Participant, :count).by(0)
      end
    end
  end

end
