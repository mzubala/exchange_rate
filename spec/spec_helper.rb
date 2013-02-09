require 'rubygems'
require 'bundler/setup'
require 'active_record'
require 'generators/exchange_rate/templates/create_exchange_rate_currency'
require 'generators/exchange_rate/templates/create_exchange_rate_eur_rate'
require 'exchange_rate' # and any other gems you need
require 'database_cleaner'


ActiveRecord::Base.establish_connection :adapter => 'sqlite3', :database => ':memory:'

ActiveRecord::Schema.define do
  CreateExchangeRateCurrency.up
  CreateExchangeRateEurRate.up
end

DatabaseCleaner.strategy = :truncation

RSpec.configure do |config|
  config.before(:each) do
    DatabaseCleaner.clean
  end
end