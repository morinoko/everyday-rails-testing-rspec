source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

gem 'rails', '~> 5.1.1'
gem "actionview", ">= 5.1.6.2"
gem "activejob", ">= 5.1.6.1"
gem 'sqlite3'
gem "rack", ">= 2.0.6"
gem 'puma', '~> 3.7'
gem 'sass-rails', '~> 5.0'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.2'
gem 'turbolinks', '~> 5'
gem 'jbuilder', '~> 2.5'
gem "nokogiri", ">= 1.10.4"
gem "loofah", ">= 2.2.3"
gem "rubyzip", ">= 1.2.2"
gem "ffi", ">= 1.9.24"
gem "sprockets", ">= 3.7.2"

group :development, :test do
  gem 'rspec-rails', '~> 3.6.0'
  gem 'factory_bot_rails', '~> 4.10.0'
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  gem 'selenium-webdriver'
end

group :development do
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'faker', require: false # for sample data in development
  gem 'spring-commands-rspec'
end

group :test do
  gem 'capybara'
  gem 'webdrivers'
  gem 'launchy', '~> 2.4.3'
  gem 'shoulda-matchers'
end

gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]

gem "bootstrap-sass", ">= 3.4.1"
gem 'jquery-rails'
gem "devise", ">= 4.6.0"
gem "paperclip", ">= 5.2.0"
gem 'geocoder'
