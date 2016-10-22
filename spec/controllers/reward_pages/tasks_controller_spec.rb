require 'rails_helper'

RSpec.describe RewardPages::TasksController, type: :controller do
  describe "POST #create" do
    before(:each) do
      @reward_page = FactoryGirl.create(:reward_page)
      @task_params = FactoryGirl.attributes_for(:task)
    end

    context "with correct params" do
      it "should create a task" do
        expect{
          post :create, params: {reward_page_id: @reward_page.identifier, task: @task_params}
        }.to change(Task, :count).by(1)
      end

      it "should redirect to the rewards page" do
        post :create, params: {reward_page_id: @reward_page.identifier, task: @task_params}
        expect(response).to redirect_to(reward_page_path(@reward_page.identifier))
      end
    end

    context "with incorret params" do
      it "should not create the task" do
        expect{
          post :create, params: {reward_page_id: @reward_page.identifier, task: {description: ""}}
        }.to change(Task, :count).by(0)
      end
    end
  end

end
