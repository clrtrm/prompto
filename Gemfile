# frozen_string_literal: true

source 'https://rubygems.org'

# ==> Core
gem 'pg', '~> 1.1'
gem 'puma', '>= 5.0'
gem 'rails', '~> 8.1.3'

# ==> Authentication
gem 'devise', '~> 5.0'
gem 'devise-jwt', '~> 0.13.0'

# ==> CORS
gem 'rack-cors'

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: %i[windows jruby]

# Use the database-backed adapters for Rails.cache, Active Job, and Action Cable
gem 'solid_cable'
gem 'solid_cache'
gem 'solid_queue'

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', require: false

# Use Active Storage variants [https://guides.rubyonrails.org/active_storage_overview.html#transforming-images]
gem 'image_processing', '~> 1.2'

# Generate usernames
gem 'haikunator', '~> 1.1'

group :development, :test do
  # ==> Debugging
  gem 'debug', platforms: %i[mri windows], require: 'debug/prelude'

  # ==> Security scanning
  gem 'brakeman', require: false
  gem 'bundler-audit', require: false

  # ==> Linting
  gem 'rubocop', '~> 1.88', require: false
  gem 'rubocop-factory_bot', '~> 2.28', require: false
  gem 'rubocop-rails', '~> 2.37', require: false
  gem 'rubocop-rspec', '~> 3.10', require: false
  gem 'rubocop-rspec_rails', '~> 2.32', require: false

  # ==> Testing
  gem 'factory_bot_rails', '~> 6.5'
  gem 'rspec-rails', '~> 8.0'

  # ==> Environment variables
  gem 'dotenv-rails', '~> 3.2'
end

group :test do
  gem 'shoulda-matchers', '~> 8.0'
end

group :development do
  gem 'letter_opener', '~> 1.10'
end

gem 'jbuilder', '~> 2.15'

gem 'resend', '~> 1.7'
