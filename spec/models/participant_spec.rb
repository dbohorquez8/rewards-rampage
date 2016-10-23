require 'rails_helper'

RSpec.describe Participant, type: :model do
  before(:each) do
    @reward_page = FactoryGirl.create(:reward_page)
  end

  it { should belong_to(:reward_page) }

  it "should set the identifier on create if not set" do
    participant = FactoryGirl.create(:participant, reward_page_id: @reward_page.id)
    expect(participant).to be_valid
    expect(participant.identifier).not_to be_nil
  end

  it "should validate uniqueness of name" do
    participant = Participant.new(name: "something")
    participant.save
    expect(Participant.new(name: "something", identifier: participant.identifier).valid?).to be_falsey
  end

  it "should validate email format" do
    participant = FactoryGirl.build(:participant, email: "something")
    participant.valid?
    expect(participant.errors[:email].size).to eq(1)
  end

  it "should allow nil value" do
    participant = FactoryGirl.build(:participant, email: nil)
    participant.valid?
    expect(participant.errors[:email].size).to eq(0)
  end

end

describe "methods" do
  describe "can_redeem?" do
    before(:each) do
      @reward_page = FactoryGirl.create(:reward_page)
      @participant = FactoryGirl.create(:participant, reward_page_id: @reward_page.id, points: 100)
    end

    it "should return true if the number of points is equal or higher" do
      reward = @reward_page.rewards.create(FactoryGirl.attributes_for(:reward, points: "100"))
      expect(@participant.can_redeem?(reward)).to be_truthy
    end

    it "should return false if the number of points is lower" do
      reward = @reward_page.rewards.create(FactoryGirl.attributes_for(:reward, points: "1002"))
      expect(@participant.can_redeem?(reward)).to be_falsey
    end
  end

  describe "complete_task!" do
    before(:each) do
      @reward_page = FactoryGirl.create(:reward_page)
      @task = @reward_page.tasks.create(FactoryGirl.attributes_for(:task, points: "100"))
      @participant = FactoryGirl.create(:participant, reward_page_id: @reward_page.id, points: 0)
    end

    it "should return truthy" do
      expect(@participant.complete_task!(@task)).to be_truthy
    end

    it "should mark the task as completed" do
      expect(@task.completed?).to be_falsey
      @participant.complete_task!(@task)
      expect(@task.reload.completed?).to be_truthy
    end

    it "should set the participant_id on the task" do
      expect(@task.participant_id).to be_nil
      @participant.complete_task!(@task)
      expect(@task.reload.participant_id).not_to be_nil
      expect(@task.reload.participant_id).to eq(@participant.id)
    end
  end

  describe "undo_task!" do
    before(:each) do
      @reward_page = FactoryGirl.create(:reward_page)
      @task = @reward_page.tasks.create(FactoryGirl.attributes_for(:task, points: "100"))
      @participant = FactoryGirl.create(:participant, reward_page_id: @reward_page.id, points: 0)
      @participant.complete_task!(@task)
      @task.reload
    end

    it "should return truthy" do
      expect(@participant.undo_task!(@task)).to be_truthy
    end

    it "should mark the task as new" do
      expect(@task.new_task?).to be_falsey
      @participant.undo_task!(@task)
      expect(@task.reload.new_task?).to be_truthy
    end

    it "should set the participant_id on the task" do
      expect(@task.participant_id).not_to be_nil
      @participant.undo_task!(@task)
      expect(@task.reload.participant_id).to be_nil
    end
  end

  describe "redeem_reward!" do
    before(:each) do
      @reward_page = FactoryGirl.create(:reward_page)
      @reward = @reward_page.rewards.create(FactoryGirl.attributes_for(:reward, points: "100"))
    end

    context "without points" do
      before(:each) do
        @participant = FactoryGirl.create(:participant, reward_page_id: @reward_page.id, points: 0)
      end

      it "should not redeem if not enough points" do
        expect(@participant.redeem_reward!(@reward)).to be_falsey
      end
    end

    context "with points" do
      before(:each) do
        @participant = FactoryGirl.create(:participant, reward_page_id: @reward_page.id, points: 150)
      end

      it "it should mark the reward as redeemed" do
        expect(@reward.not_redeemed?).to be_truthy
        @participant.redeem_reward!(@reward)

        expect(@reward.reload.not_redeemed?).to be_falsey
      end

      it "should set the participant_id in the reward" do
        expect(@reward.participant_id).to be_nil
        @participant.redeem_reward!(@reward)

        expect(@reward.reload.participant_id).not_to be_nil
        expect(@reward.reload.participant_id).to eq(@participant.id)
      end

      it "should make the discount of points" do
        expect{
          @participant.redeem_reward!(@reward)
        }.to change(@participant, :points).by(@reward.points * -1)
      end

      it "should not let to redeem rewards that are not in my reward_page" do
        reward_mala = FactoryGirl.create(:reward, points: "100")
        expect{
          @participant.redeem_reward!(reward_mala)
        }.to raise_error(RuntimeError, /NOoooo Cheater/)
      end

      it "should not let me redeem rewards that are redeemed" do
        @reward.redeem!
        @reward.update_attribute(:participant_id, 1)
        expect(@participant.redeem_reward!(@reward)).to be_falsey
      end
    end
  end
end
