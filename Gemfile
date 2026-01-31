source "https://rubygems.org"

gem "rails", "~> 8.0.3"
gem "propshaft"
gem "puma", ">= 5.0"
gem "importmap-rails"
gem "turbo-rails"
gem "stimulus-rails"
gem "jbuilder"
gem "tailwindcss-rails"
gem "view_component"
gem "bcrypt", "~> 3.1.7"
gem "devise"
gem "tzinfo-data", platforms: %i[ windows jruby ]
gem "hotwire-spark"
gem "bootsnap", require: false
gem "kamal", require: false
gem "thruster", require: false
gem "heroicon", "~> 1.0"

group :development, :test do
  gem "sqlite3", ">= 2.1"
  gem "debug", platforms: %i[ mri windows ], require: "debug/prelude"
  gem "brakeman", require: false
  gem "rubocop-rails-omakase", require: false
end

group :production do
  gem "pg"
end

gem "solid_cache"
gem "solid_queue"
gem "solid_cable"

group :development do
  gem "web-console"
end

group :test do
  gem "capybara"
  gem "selenium-webdriver"
end
