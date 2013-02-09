module ExchangeRate

  class Currency < ActiveRecord::Base

    self.table_name = "exchange_rate_currency"

    attr_accessible :code

  end

end