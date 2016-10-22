require 'rails_helper'

RSpec.describe Participants::CompleteTasksController, type: :controller do
  describe 'on POST to #create' do
    before(:each) do
      @reward_page = FactoryGirl.create(:reward_page)
      @participant = @reward_page.participants.create(FactoryGirl.attributes_for(:participant))
      @task        = @reward_page.tasks.create(FactoryGirl.attributes_for(:task))
    end

    it "should raise 404 if the participant is not found" do
      expect{
        process :create, method: :post, params: {participant_id: "222", task_id: "ss"}
      }.to raise_error(ActiveRecord::RecordNotFound, /Couldn't find Participant/)
    end

    it "should raise 404 if the task is not found" do
      expect{
        process :create, method: :post, params: {participant_id: @participant.identifier, task_id: "ss"}
      }.to raise_error(ActiveRecord::RecordNotFound, /Couldn't find Task/)
    end

    it "should mark the task a completed" do
      process :create, method: :post, params: {participant_id: @participant.identifier, task_id: @task.id}
      expect(@task.reload.status).to eq('completed')
    end
  end

  describe 'on DELETE to #destroy' do
    before(:each) do
      @reward_page = FactoryGirl.create(:reward_page)
      @participant = @reward_page.participants.create(FactoryGirl.attributes_for(:participant))
      @task        = @reward_page.tasks.create(FactoryGirl.attributes_for(:task))
    end

    it "should raise 404 if the participant is not found" do
      expect{
        process :destroy, method: :delete, params: {participant_id: "222", task_id: "ss"}
      }.to raise_error(ActiveRecord::RecordNotFound, /Couldn't find Participant/)
    end

    it "should raise 404 if the task is not found" do
      expect{
        process :destroy, method: :delete, params: {participant_id: @participant.identifier, task_id: "ss"}
      }.to raise_error(ActiveRecord::RecordNotFound, /Couldn't find Task/)
    end

    it "should mark the task a new" do
      process :create, method: :post, params: {participant_id: @participant.identifier, task_id: @task.id}
      process :destroy, method: :delete, params: {participant_id: @participant.identifier, task_id: @task.id}
      expect(@task.reload.status).to eq('new')
    end
  end
end
