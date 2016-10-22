class ParticipantsController < ApplicationController
  # renders the participant show page
  def show
    @reward_page = current_participant.reward_page
  end
end
