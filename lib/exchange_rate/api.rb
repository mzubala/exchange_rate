module ExchangeRate

  module Api

    def at(date, base, counter)
      eur_base_rate = eur_rate(date, base)
      eur_counter_rate = eur_rate(date, counter)
      eur_base_rate.calculate_rate(eur_counter_rate).to_f if eur_base_rate && eur_counter_rate
    end

    def currencies
      (Currency.all.collect { |c| c.code } << "EUR").sort
    end

    private

    def currency code
      ExchangeRate::Currency.find_by_code(code) || raise("Undefined currency #{code}")
    end

    def eur_rate date, code
      if code == "EUR"
        ExchangeRate::EurRate.new(rate: 1.0)
      else
        ExchangeRate::EurRate.at(date, currency(code)).first
      end
    end

  end

end
