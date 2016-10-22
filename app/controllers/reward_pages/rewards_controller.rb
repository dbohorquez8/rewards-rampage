module RewardPages
  class RewardsController < ApplicationController
    def index
      @rewards = current_reward_page.rewards
    end

    def new
      @reward = current_reward_page.rewards.build
    end

    def create
      @reward = current_reward_page.rewards.build(reward_params)

      respond_to do |format|
        if @reward.save
          format.html { redirect_to reward_page_path(current_reward_page.identifier) }
          format.js { }
        else
          format.html { render action: "new" }
          format.js { }
        end
      end
    end

    def destroy
      @reward = current_reward_page.rewards.find(reward_id_param)
      @reward.destroy
      redirect_to reward_page_path(id: current_reward_page.identifier)
    end

    private

    def reward_id_param
      params.require(:id)
    end

    def reward_params
      params.require(:reward).permit(:name, :description, :photo, :points)
    end
  end
end
