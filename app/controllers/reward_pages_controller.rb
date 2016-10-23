class RewardPagesController < ApplicationController
  def index

  end

  def new
    @reward_page = RewardPage.create(name: Haikunator.haikunate(100))
    add_to_cookie(:owner, @reward_page.identifier)
    redirect_to edit_reward_page_path(id: @reward_page.identifier)
  end

  def edit
    current_reward_page
  end

  def change_email
    @reward = current_reward_page
    @reward.update_attributes(params.require(:reward_page).permit(:owner_email))
    redirect_to(edit_reward_page_path(current_reward_page.identifier)) unless request.xhr?
  end

  def change_name
    current_reward_page.update_attributes(params.require(:reward_page).permit(:name))
    redirect_to(edit_reward_page_path(current_reward_page.identifier))
  end
end
