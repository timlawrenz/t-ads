# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.4.2'

gem 'aasm'
gem 'active_model_serializers'
gem 'aws-sdk-s3', require: false
gem 'bcrypt', '~> 3.1.7'
gem 'bootsnap', require: false
gem 'down'
gem 'friendly_id'
gem 'gl_command', git: 'https://github.com/givelively/gl_command.git'
gem 'haml-rails'
gem 'image_processing'
gem 'importmap-rails'
gem 'kamal', require: false
gem 'oj'
gem 'pg', '~> 1.1'
gem 'propshaft'
gem 'puma'
gem 'rails'
gem 'sentry-rails'
gem 'sentry-ruby'
gem 'solid_cable'
gem 'solid_cache'
gem 'solid_queue'
gem 'stimulus-rails'
gem 'tailwindcss-rails'
gem 'thruster', require: false
gem 'turbo-rails'
gem 'ulid'
gem 'view_component'

group :development, :test do
  gem 'brakeman'
  gem 'debug', platforms: %i[mri mingw x64_mingw]
  gem 'dotenv-rails'
  gem 'factory_bot_rails'
  gem 'reek'
  gem 'timecop'
  gem 'webdrivers'
end

group :development do
  gem 'gl_lint', require: false
  gem 'listen'
  gem 'rspec-rails'
  gem 'rubocop', require: false
  gem 'rubocop-performance', require: false
  gem 'rubocop-rails', require: false
  gem 'rubocop-rspec', require: false
  gem 'spring'
  gem 'spring-commands-rspec'
  gem 'spring-commands-rubocop'
  gem 'web-console'
end

group :test do
  gem 'capybara'
  gem 'capybara-screenshot'
  gem 'database_cleaner'
  gem 'database_cleaner-active_record'
  gem 'launchy'
  gem 'n_plus_one_control'
  gem 'selenium-webdriver'
  gem 'shoulda-matchers'
  gem 'simplecov', require: false
end
