module ExchangeRate

  class EurRate < ActiveRecord::Base

    self.table_name = "exchange_rate_eur_rate"

    attr_accessible :rate, :rate_date, :currency, :currency_id

    belongs_to :currency, class_name: "ExchangeRate::Currency"

    scope :at, (lambda do |date, currency|
      joins(:currency).where(currency_id: currency.id).where(:rate_date => date)
    end)

    def calculate_rate counter
      counter.rate / rate
    end

  end

end