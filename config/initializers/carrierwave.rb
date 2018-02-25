if Rails.env.test?
  CarrierWave.configure do |config|
    config.storage = :file
    config.enable_processing = false
  end
end 

if Rails.env.development?
  CarrierWave.configure do |config|
    config.storage = :file
  end
end

if Rails.env.production?
  CarrierWave.configure do |config|
    config.root = Rails.root.join('tmp')
    config.cache_dir = 'carrierwave'
    config.fog_provider = 'fog/aws'
    config.fog_credentials = {
      provider:              'AWS',
      aws_access_key_id:     ENV['AWS_ACCESS_KEY_ID'],
      aws_secret_access_key: ENV['AWS_SECRET_ACCESS_KEY'],
      region:                ENV['AWS_REGION'],
    }
    config.storage = :fog
    config.asset_host =     ENV['AWS_ENDPOINT']
    config.fog_directory  = ENV['AWS_BUCKET_NAME']
    config.fog_public     = true
    config.fog_attributes = { cache_control: "public, max-age=#{365.days.to_i}" }
  end
end