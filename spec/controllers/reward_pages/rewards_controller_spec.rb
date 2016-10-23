require 'rails_helper'

RSpec.describe RewardPages::RewardsController, type: :controller do
  it { expect(reward_page_rewards_path(1)).to eq('/s/1/rewards') }
  it { expect(new_reward_page_reward_path(1)).to eq('/s/1/rewards/new') }
  it { expect(reward_page_reward_path(1,2)).to eq('/s/1/rewards/2') }
  it {
    expect(get: new_reward_page_reward_path(1)).to route_to({
      controller:     'reward_pages/rewards',
      action:         'new',
      reward_page_id: '1'
    })
  }
  it {
    expect(post: reward_page_rewards_path(1)).to route_to({
      controller:     'reward_pages/rewards',
      action:         'create',
      reward_page_id: '1'
    })
  }
  it {
    expect(delete: reward_page_reward_path(1,2)).to route_to({
      controller:     'reward_pages/rewards',
      action:         'destroy',
      reward_page_id: '1',
      id:             '2'
    })
  }

  let(:reward_page) { FactoryGirl.create(:reward_page) }

  describe "POST #create" do
    let(:params) {
      { reward: FactoryGirl.attributes_for(:reward) }
    }
    let(:process_request) {
      post :create, params: params.merge(reward_page_id: reward_page.identifier)
    }

    before do
      request.headers['Content-Type'] = "multipart/form-data"
    end

    it { expect{ process_request }.to change(Reward, :count).by(1) }

    context "with valid attributes" do
      before(:each) do
        process_request
      end

      it { expect(assigns(:reward)).not_to be_blank }
      it { expect(assigns(:reward).errors.count).to be 0 }
      it { expect(response).to redirect_to(reward_page_path(reward_page.identifier)) }
    end

    [:name, :photo, :points].each do |field_name|
      it {
        params[:reward].delete(field_name)
        expect{ process_request }.not_to change(Reward, :count)
      }

      context "without '#{field_name}'' value" do
        before(:each) do
          params[:reward].delete(field_name)
          process_request
        end

        it { expect(assigns(:reward).errors.count).to be > 0 }
        it { expect(response).not_to be_a_redirect }
        it { expect(response).to render_template('new') }
      end
    end
  end

  describe "DELETE #destroy" do
    let(:reward) { FactoryGirl.create(:reward, reward_page: reward_page) }
    let(:process_request) {
      delete :destroy, params: {reward_page_id: reward_page.identifier, id: reward.id}
    }

    it { reward; expect{ process_request }.to change(Reward, :count) }

    context "with valid attributes" do
      before(:each) do
        process_request
      end

      it { expect(response).to redirect_to(reward_page_path(reward_page.identifier)) }
    end

    context "ajax enabled" do
      before(:each) do
        delete :destroy, params: {reward_page_id: reward_page.identifier, id: reward.id}, xhr: true
      end

      it { expect(response).not_to be_a_redirect }
      it { expect(response).to render_template('reward_pages/rewards/destroy') }
    end
  end
end
