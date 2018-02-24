source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

gem 'cancancan',                       '=1.15.0'
gem 'fog-aws'
gem 'carrierwave',                     '~> 1.0'
gem 'coffee-rails',                    '~> 4.2'
gem 'devise'
gem 'devise-i18n'
gem 'enumerize'
gem 'evil_icons'
gem 'inherited_resources'
gem 'mini_magick'
gem 'pg',                              '~> 0.21'
gem 'puma',                            '~> 3.7'
gem 'rails',                           '~> 5.1.5'
gem 'react-rails'
gem 'sass-rails',                      '~> 5.0'
gem 'simple_form'
gem 'slim-rails'
gem 'uglifier',                        '>= 1.3.0'
gem 'webpacker'

group :development, :test do
  gem 'dotenv-rails'
  gem 'rspec-rails',                   '~> 3.6'
  gem 'factory_bot_rails'
  gem 'ffaker'
end

group :development do
  gem 'annotate'
  gem 'hirb'
  gem 'listen',                        '>= 3.0.5', '< 3.2'
  gem 'spring'
  gem 'spring-watcher-listen',         '~> 2.0.0'
  gem 'web-console',                   '>= 3.3.0'
end

group :test do
  gem 'database_cleaner'
  gem 'rails-controller-testing'
  gem 'shoulda-matchers',              '~> 3.1'
  gem 'simplecov'
end
