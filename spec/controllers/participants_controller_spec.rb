require 'rails_helper'

RSpec.describe ParticipantsController, type: :controller do
  describe 'on GET to #show' do
    context "without the id" do
      it "should raise 404" do
        expect{
          process :show, method: :get, params: {id: ""}
        }.to raise_error(ActiveRecord::RecordNotFound)
      end
    end

    context "with the id" do
      before(:each) do
        @reward_page = FactoryGirl.create(:reward_page)
        @participant = @reward_page.participants.create(FactoryGirl.attributes_for(:participant))
      end

      it "should load the participant" do
        process :show, method: :get, params: {id: @participant.identifier}
        expect(assigns(:current_participant)).not_to be_nil
      end

      it "should render the show page" do
        process :show, method: :get, params: {id: @participant.identifier}
        expect(response).to render_template("show")
      end

      it "should load the reward_page" do
        process :show, method: :get, params: {id: @participant.identifier}
        expect(assigns(:reward_page)).not_to be_nil
      end
    end
  end
end
