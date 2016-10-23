class RewardPagesController < ApplicationController
  def new
    @reward_page = RewardPage.create(name: Haikunator.haikunate(100))
    redirect_to edit_reward_page_path(id: @reward_page.identifier)
  end

  def edit
    current_reward_page
  end

  def change_email
    @reward = current_reward_page
    @reward.update_attributes(params.require(:reward_page).permit(:owner_email))
  end
end
