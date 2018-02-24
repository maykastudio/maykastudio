class ImageUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick
  CarrierWave::SanitizedFile.sanitize_regexp = /[^a-zA-Zа-яА-ЯёЁ0-9\.\_\-\+\s\:]/

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{model.id}"
  end

  # Provide a default URL as a default if there hasn't been a file uploaded:
  # def default_url(*args)
  #   # For Rails 3.1+ asset pipeline compatibility:
  #   # ActionController::Base.helpers.asset_path("fallback/" + [version_name, "default.png"].compact.join('_'))
  #
  #   "/images/fallback/" + [version_name, "default.png"].compact.join('_')
  # end

  # Process files as they are uploaded:
  # process scale: [200, 300]
  #
  # def scale(width, height)
  #   # do something
  # end

  version :preview do
    process resize_and_pad: [850, 850, :transparent, 'Center']
    process :watermark
  end

  version :thumbnail do
    process resize_and_pad: [250, 250, :transparent, 'Center']
  end

  def watermark
    watermark = "#{Rails.root}/app/assets/images/watermark.png"

    manipulate! do |img|
      img = img.composite(MiniMagick::Image.open(watermark), "png") do |c|
        c.gravity "Center"
      end
    end
  end

  def extension_whitelist
    %w(jpg jpeg gif png)
  end

  def md5
    @md5 ||= Digest::MD5.hexdigest model.send(mounted_as).read.to_s
  end

  def filename
    @name ||= "#{md5}#{File.extname(super)}" if super
  end
end
