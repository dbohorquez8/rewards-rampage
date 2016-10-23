class ParticipantsController < ApplicationController
  # renders the participant show page
  def show
    @reward_page = current_participant.reward_page
  end

  def change_email
    @participant = current_participant
    @participant.update_attributes(params.require(:participant).permit(:email))
    redirect_to(participant_path(current_participant.identifier)) unless request.xhr?
  end
end
