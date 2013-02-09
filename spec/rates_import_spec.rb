require 'spec_helper'

describe ExchangeRate::RatesImport do

  describe "#import_from_ecb!" do

    it "should import exchange rates" do
      ExchangeRate::RatesImport.import_from_ecb_xml!(test_xml("rates_02_08"))
      ExchangeRate::EurRate.count.should == 33
      ExchangeRate::Currency.count.should == 33
      usd = ExchangeRate::Currency.find_by_code("USD")
      ExchangeRate::EurRate.at("2013-02-08", usd).first.rate.should == 1.3374
    end

    it "should not duplicate rates and currencies" do
      ExchangeRate::RatesImport.import_from_ecb_xml!(test_xml("rates_02_08"))
      ExchangeRate::RatesImport.import_from_ecb_xml!(test_xml("rates_02_08_07"))
      ExchangeRate::EurRate.count.should == 66
      ExchangeRate::Currency.count.should == 33
    end

    def test_xml f
      Nokogiri::XML(open(File.dirname(__FILE__) + "/#{f}.xml"))
    end

  end

end
