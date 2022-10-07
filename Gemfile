source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "3.1.2"
gem "rails", "~> 7.0.4"
gem "pg", "~> 1.1"
gem "puma", "~> 5.0"
gem "tzinfo-data", platforms: %i[ mingw mswin x64_mingw jruby ]
gem "bootsnap", require: false
gem "dotenv-rails"
gem "httparty"
gem 'i18n'
gem 'rswag-api'
gem 'rswag-ui'

group :development, :test do
  gem "pry-rails"
  gem "factory_bot_rails"
  gem 'shoulda-matchers'

  %w[rspec-core rspec-expectations rspec-mocks rspec-rails rspec-support].each do |lib|
    gem lib, git: "https://github.com/rspec/#{lib}.git", branch: 'main'
  end

  gem "vcr"
  gem "webmock"
  gem "rswag-specs"
end
