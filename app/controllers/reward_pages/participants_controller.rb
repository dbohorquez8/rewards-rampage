class RewardPages::ParticipantsController < ApplicationController
  def new
    @participant = current_reward_page.participants.build
  end

  def create
    @participant = current_reward_page.participants.build(participant_params)

    respond_to do |format|
      if @participant.save
        format.html { redirect_to reward_page_path(current_reward_page.identifier) }
        format.js { }
      else
        format.html { render action: "new" }
        format.js { }
      end
    end
  end

  private

  def participant_params
    params.require(:participant).permit(:name, :email)
  end
end
