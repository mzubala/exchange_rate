# ExchangeRate

## Installation

Add this line to your application's Gemfile:

    gem 'exchange_rate', git: "git@github.com:mzubala/exchange_rate.git"

And then execute:

    $ bundle

Gem stores exchange rates in relational database and it uses active_record.
To update your db schema in rails app generate and run migrations:

    $ rails generate exchange_rate:install
    $ rake db:migrate

Now you can import some exchange rates:

    $ rake exchange_rate:import

## Usage

Example call:

  $ ExchangeRate.at(date, "USD", "GBP")

List of available currencies:

  $ ExchangeRate.currencies

