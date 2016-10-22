class RewardPages::ParticipantsController < ApplicationController
  def new
    @participant = current_reward_page.participants.build
  end

  def create
    @participant = current_reward_page.participants.build(participant_params)

    if @participant.save
      redirect_to reward_page_path(id: current_reward_page.identifier)
    else
      render "new"
    end
  end

  private

  def participant_params
    params.require(:participant).permit(:name)
  end
end
