require 'rubygems'
require 'spork'
require 'spork/ext/ruby-debug'

Spork.prefork do
  ENV["RAILS_ENV"] ||= 'test'
  require File.expand_path("../../config/environment", __FILE__)
  require 'rspec/rails'
  require 'rspec/autorun'
  require 'database_cleaner'
  require 'ffaker'

  Dir[Rails.root.join("spec/support/**/*.rb")].each {|f| require f}

  RSpec.configure do |config|
    config.fixture_path = "#{::Rails.root}/spec/fixtures"
    config.global_fixtures = :all

    config.mock_with :rspec
    config.infer_base_class_for_anonymous_controllers = false

    config.before(:suite) do
      DatabaseCleaner.strategy = :transaction
      DatabaseCleaner.clean_with(:truncation)
    end

    config.before(:each) do
      DatabaseCleaner.start
    end

    config.after(:each) do
      DatabaseCleaner.clean
    end
  end

end

Spork.each_run do
  FactoryGirl.reload
  Dir["#{Rails.root}/app/models/**/*.rb"].each{|f| load f}
end
