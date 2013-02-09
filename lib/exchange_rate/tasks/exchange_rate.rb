namespace :exchange_rate do

  desc "Import rates from ecb"
  task :import => :environment do
    ExchangeRate::RatesImport.import_from_ecb_xml!
  end

end