require 'nokogiri'
require 'open-uri'

module ExchangeRate

  module RatesImport

    class << self

      def import_from_ecb_xml!(xml = nil)
        xml = fetch_xml if xml.nil?
        xml.remove_namespaces!
        ActiveRecord::Base.transaction do
          xml.css("/Envelope/Cube/Cube").each do |rates_cube|
            date = rates_cube.attr("time")
            puts "Processing rates at #{date}"
            rates_cube.xpath("./Cube").each do |rate|
              currency = find_or_create_currency rate.attr("currency")
              rate = rate.attr("rate")
              unless EurRate.at(date, currency).count == 1
                EurRate.create!(rate: rate, currency: currency, rate_date: date)
              end
            end
          end
        end
      end

      private

      def fetch_xml
        Nokogiri::XML(open("http://www.ecb.europa.eu/stats/eurofxref/eurofxref-hist-90d.xml"))
      end

      def find_or_create_currency code
        Currency.find_by_code(code) || Currency.create!(code: code)
      end

    end

  end

end