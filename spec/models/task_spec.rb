require 'rails_helper'

RSpec.describe Task, type: :model do
  it { should belong_to(:reward_page) }
  it { should belong_to(:participant) }

  it { should validate_presence_of(:description) }
  it { should validate_presence_of(:title) }
  it { should validate_length_of(:title).is_at_most(140) }
  it { should validate_presence_of(:points) }
  it { should validate_presence_of(:reward_page_id) }
end

describe Task, "methods" do
  before(:each) do
    @reward_page = FactoryGirl.create(:reward_page)
    @task = @reward_page.tasks.create(FactoryGirl.attributes_for(:task, points: "100"))
    @participant = FactoryGirl.create(:participant, reward_page_id: @reward_page.id, points: 100)
  end

  describe "award_points!" do
    it "should add the points to the participant" do
      old_points = @participant.points
      @participant.complete_task!(@task)
      @task.award_points!
      expect(@participant.reload.points).to eq(old_points + @task.points)
    end
  end
end
