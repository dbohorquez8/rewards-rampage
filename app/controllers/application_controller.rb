class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  helper_method :current_reward_page
  helper_method :current_participant

  protected

  # returns the current reward page based on a param in the route
  def current_reward_page
    @current_reward_page ||= RewardPage.find_by!(identifier: params[:reward_page_id] || params[:id])
  end

  # returns the current participant
  def current_participant
    @current_participant ||= Participant.find_by!(identifier: params[:id] || params[:participant_id])
  end
end
