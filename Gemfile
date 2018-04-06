source 'https://rubygems.org'

ruby '2.3.5'
gem 'rails'
gem 'bcrypt'
gem 'bootstrap-sass'
gem 'puma'
gem 'sprockets'
gem 'sass-rails'
gem 'uglifier'
gem 'coffee-rails'
gem 'jquery-rails'
gem 'turbolinks'
gem 'jbuilder'
gem 'haml'
gem 'faker'
gem 'bootstrap_form'
gem 'sdoc'
gem 'font-awesome-sass'
gem 'jquery-ui-rails'
gem "datagrid", :git => "git://github.com/bogdan/datagrid.git"
gem "kaminari"
gem "httparty"

group :development, :test do
  gem 'sqlite3'
  gem 'byebug', platform: :mri
  gem 'jasmine-rails'
  gem 'capybara'
  gem 'capybara-webkit'
  gem "headless"
end

group :development do
  gem 'web-console'
  gem 'listen'
  gem 'spring'
  gem 'spring-watcher-listen'
  gem 'haml-rails'
end

group :test do
  gem 'rspec-rails'
  gem 'guard-rspec'
  gem 'simplecov', :require => false
  gem 'cucumber-rails', :require => false
  gem 'cucumber-rails-training-wheels' # basic imperative step defs
  gem 'database_cleaner' # required by Cucumber
  gem 'factory_bot_rails'
  gem 'metric_fu'        # collect code metrics
  gem 'rails-controller-testing'
end

group :production do
  gem 'pg'
  gem 'rails_12factor'  # Heroku-specific production settings
end