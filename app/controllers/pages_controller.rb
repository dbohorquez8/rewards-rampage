class PagesController < ApplicationController
  def index
  end

  def signature
  	render :nothing and return unless params[:data].present?
  	render text: Digest::SHA1.hexdigest(string_to_sign)
  end

  private

  def string_to_sign
	return "" unless params[:data].present?
	"#{params[:data].sort.map {|key, val| "#{key}=#{val}"}.join('&')}#{ENV['cloudinary_api_secret']}"
  end
end
