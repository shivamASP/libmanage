source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.7.2'

gem 'activejob'
gem 'bootsnap', '>= 1.4.4', require: false
gem 'delayed_job_active_record'
gem 'devise', '~> 4.7', '>= 4.7.3'
gem 'jbuilder', '~> 2.7'
gem 'pg', '~> 1.1'
gem 'puma', '~> 5.0'
gem 'rails', '~> 6.1.3', '>= 6.1.3.1'
gem 'rails_admin', '~> 2.0'
gem 'sass-rails', '>= 6'
gem 'turbolinks', '~> 5'
gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]
gem 'webpacker', '~> 5.0'
gem 'whenever', require: false

group :development do
  gem 'web-console', '>= 4.1.0'
  gem 'listen', '~> 3.3'
  gem 'rack-mini-profiler', '~> 2.0'
  gem 'spring'
end

group :test do
  gem 'selenium-webdriver'
  gem 'webdrivers'
  gem 'webmock'
  gem 'whenever-test'
end


group :development, :test do
  gem 'byebug', platforms: %i[mri mingw x64_mingw]
  gem 'capybara', '>= 3.26'
  gem 'factory_bot_rails'
  gem 'faker'
  gem 'rspec-mocks'
  gem 'rspec-rails'
  gem 'rspec-rake'
  gem 'simplecov', require: false
end
