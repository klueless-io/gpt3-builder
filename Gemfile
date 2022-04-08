# frozen_string_literal: true

source 'https://rubygems.org'

# Specify your gem's dependencies in handlebars_helpers.gemspec
gemspec

# group :development do
#   # Currently conflicts with GitHub actions and so I remove it on push
#   # pry on steroids
#   gem 'jazz_fingers'
#   gem 'pry-coolline', github: 'owst/pry-coolline', branch: 'support_new_pry_config_api'
# end

group :development, :test do
  gem 'guard-bundler'
  gem 'guard-rspec'
  gem 'guard-rubocop'
  gem 'rake', '~> 12.0'
  gem 'rake-compiler', require: false
  gem 'rspec', '~> 3.0'
  gem 'rubocop'
  gem 'rubocop-rake', require: false
  gem 'rubocop-rspec', require: false
end
