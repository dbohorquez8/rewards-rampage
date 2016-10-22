class Participants::RedeemRewardsController < ApplicationController
  def create
    @reward_page = current_participant.reward_page
    @reward = @reward_page.rewards.not_redeemed.find(params[:reward_id])
    current_participant.redeem_reward!(@reward)
  end
end
