# encoding: utf-8

class PhotoUploader < CarrierWave::Uploader::Base
  include Cloudinary::CarrierWave  

  # version :full do
  #   process :convert => 'jpg'
  #   process :custom_crop
  # end

  # def custom_crop
  #   return :x => model.crop_x, :y => model.crop_y, 
  #     :width => model.crop_width, :height => model.crop_height, :crop => :crop
  # end
end
