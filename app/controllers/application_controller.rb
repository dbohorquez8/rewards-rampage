class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  rescue_from ActiveRecord::RecordNotFound, with: :show_404

  helper_method :current_reward_page
  helper_method :current_participant

  protected

  def add_to_cookie(name, value)
    if cookies[name].present?
      current_data = JSON.parse(cookies[name])
      current_data << value unless current_data.include?(value)
      cookies[name] = current_data.to_json
    else
      cookies[name] = [value].to_json
    end
  end

  def show_404
    redirect_to no_way_baby_path
  end

  # returns the current reward page based on a param in the route
  def current_reward_page
    @current_reward_page ||= RewardPage.find_by!(identifier: params[:reward_page_id] || params[:id])
  end

  # returns the current participant
  def current_participant
    @current_participant ||= Participant.find_by!(identifier: params[:participant_id] || params[:id])
  end
end
