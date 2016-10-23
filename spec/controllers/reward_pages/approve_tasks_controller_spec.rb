require 'rails_helper'

RSpec.describe RewardPages::ApproveTasksController, type: :controller do
  describe 'on POST to #create' do
    before(:each) do
      @reward_page = FactoryGirl.create(:reward_page)
      @participant = @reward_page.participants.create(FactoryGirl.attributes_for(:participant))
      @task        = @reward_page.tasks.create(FactoryGirl.attributes_for(:task))
    end

    it "should raise 404 if the reward_page is not found" do
      expect{
        process :create, method: :post, params: {reward_page_id: "222", task_id: "ss"}
      }.to raise_error(ActiveRecord::RecordNotFound, /Couldn't find RewardPage/)
    end

    it "should raise 404 if the task is not found" do
      expect{
        process :create, method: :post, params: {reward_page_id: @reward_page.identifier, task_id: "ss"}
      }.to raise_error(ActiveRecord::RecordNotFound, /Couldn't find Task/)
    end

    it "should mark the task as approved" do
      @participant.complete_task!(@task)
      process :create, method: :post, params: {reward_page_id: @reward_page.identifier, task_id: @task.id}, format: :js
      expect(@task.reload.status).to eq('approved')
    end
  end

  describe 'on DELETE to #destroy' do
    before(:each) do
      @reward_page = FactoryGirl.create(:reward_page)
      @participant = @reward_page.participants.create(FactoryGirl.attributes_for(:participant))
      @task        = @reward_page.tasks.create(FactoryGirl.attributes_for(:task))
    end

    it "should raise 404 if the reward_page is not found" do
      expect{
        process :destroy, method: :delete, params: {reward_page_id: "222", task_id: "ss"}
      }.to raise_error(ActiveRecord::RecordNotFound, /Couldn't find RewardPage/)
    end

    it "should raise 404 if the task is not found" do
      expect{
        process :destroy, method: :delete, params: {reward_page_id: @reward_page.identifier, task_id: "ss"}
      }.to raise_error(ActiveRecord::RecordNotFound, /Couldn't find Task/)
    end

    it "should mark the task a new" do
      @participant.complete_task!(@task)
      process :destroy, method: :delete, params: {reward_page_id: @reward_page.identifier, task_id: @task.id}, format: :js
      expect(@task.reload.status).to eq('new_task')
    end

    it "should remove the participant id from the task" do
      @participant.complete_task!(@task)
      expect(@task.reload.participant_id).to eq(@participant.id)
      process :destroy, method: :delete, params: {reward_page_id: @reward_page.identifier, task_id: @task.id}, format: :js
      expect(@task.reload.participant_id).to be_nil
    end
  end
end
