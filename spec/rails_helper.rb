ENV["RAILS_ENV"] ||= 'test'
require File.expand_path("../../config/environment", __FILE__)

require 'spec_helper'
require 'rspec/rails'
require 'shoulda/matchers'
require 'devise'
require 'database_cleaner'
require 'ffaker'

Dir[Rails.root.join("spec/support/**/*.rb")].each { |f| require f }

ActiveRecord::Migration.maintain_test_schema!

Shoulda::Matchers.configure do |config|
  config.integrate do |with|
    with.test_framework :rspec
    with.library :rails
  end
end

RSpec.configure do |config|
  config.include FactoryBot::Syntax::Methods
  config.include Warden::Test::Helpers
  config.include Devise::Test::ControllerHelpers, type: :controller

  [:controller, :view, :request].each do |type|
    config.include ::Rails::Controller::Testing::TestProcess, :type => type
    config.include ::Rails::Controller::Testing::TemplateAssertions, :type => type
    config.include ::Rails::Controller::Testing::Integration, :type => type
  end

  config.use_transactional_fixtures = false
  config.infer_spec_type_from_file_location!

  config.before(:suite) do
    DatabaseCleaner.clean_with(:truncation)
    Warden.test_mode!

    Dir["#{Rails.root}/app/uploaders/**/*.rb"].each{ |f| require f }
    CarrierWave::Uploader::Base.descendants.each do |klass|
      next if klass.anonymous?

      klass.class_eval do
        storage :file

        def cache_dir
          'test_uploads/tmp'
        end

        def store_dir
          "test_uploads/#{model.class.to_s.underscore}/#{model.id}"
        end
      end
    end
  end

  config.before(:each) do
    DatabaseCleaner.strategy = :transaction
  end

  config.before(:each, js: true) do
    DatabaseCleaner.strategy = :truncation
  end

  config.before(:each) do
    DatabaseCleaner.start
  end

  config.after(:each) do
    DatabaseCleaner.clean
    Warden.test_reset!
  end

  config.after(:suite) do
    FileUtils.rm_rf(Dir["#{Rails.root}/public/test_uploads"])
  end
end