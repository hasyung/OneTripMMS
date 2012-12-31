# encoding: utf-8

class ImageUploader < CarrierWave::Uploader::Base
  
  include CarrierWave::MiniMagick
  include Sprockets::Helpers::RailsHelper
  include Sprockets::Helpers::IsolatedHelper

  storage :file
  
  CarrierWave::SanitizedFile.sanitize_regexp = /[^[:word:]\.\-\+]/

  def store_dir
    "uploads/#{model.class.to_s.underscore}"
  end

  def extension_white_list
    %w(jpg jpeg gif png)
  end
  
  def filename
    if super.present?
      @name ||= Digest::MD5.hexdigest(File.dirname(current_path))
      "#{@name}.#{file.extension.downcase}"
    end
  end

end
