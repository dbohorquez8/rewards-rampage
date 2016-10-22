class RewardPagesController < ApplicationController
  def new
    @reward_page = RewardPage.create(name: Haikunator.haikunate(100))
    redirect_to edit_reward_page_path(id: @reward_page.identifier)
  end

  def edit
    @reward_page = RewardPage.find_by!(identifier: params[:id])
  end
end
