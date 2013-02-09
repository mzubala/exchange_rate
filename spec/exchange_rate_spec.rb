require 'spec_helper'

describe ExchangeRate do

  let(:date) { Date.parse("2013-01-01") }
  let(:gbp_rate) { 0.8624 }
  let(:usd_rate) { 1.3546 }

  before(:each) do
    usd = ExchangeRate::Currency.create(code: "USD")
    gpb = ExchangeRate::Currency.create(code: "GPB")
    ExchangeRate::EurRate.create(rate_date: date, currency: gpb, rate: gbp_rate)
    ExchangeRate::EurRate.create(rate_date: date, currency: usd, rate: usd_rate)
  end

  describe "#at" do

    it "should calculate exchange rate" do
      ExchangeRate.at(date, "USD", "GPB").should == gbp_rate / usd_rate
      ExchangeRate.at(date, "GPB", "USD").should == usd_rate / gbp_rate
    end

    it "should raise exception when invalid currency" do
      expect { ExchangeRate.at(date, "USD", "nnn") }.to raise_error("Undefined currency nnn")
    end

    it "should be nil when there is no rate for given date" do
      d = date + 1.day
      ExchangeRate.at(d, "USD", "GPB").should be_nil
    end

    it "should accept EUR" do
      ExchangeRate.at(date, "EUR", "USD").should == usd_rate
      ExchangeRate.at(date, "USD", "EUR").should == 1.0 / usd_rate
    end

  end

  describe "#currencies" do

    it "should return currencies ordered by name" do
      ExchangeRate.currencies.should == ["EUR", "GPB", "USD"]
    end

  end

end