module ExchangeRate
  if defined?(Rails::Railtie)
    class Railitie < Rails::Railtie
      rake_tasks do
        Dir[File.join(File.dirname(__FILE__), 'tasks/*.rb')].each { |f| load f }
      end
    end
  end
end
