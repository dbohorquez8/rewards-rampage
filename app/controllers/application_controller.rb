class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  helper_method :current_reward_page

  protected

  # returns the current reward page based on a param in the route
  def current_reward_page
    @current_reward_page ||= RewardPage.find_by!(identifier: params[:id])
  end
end
