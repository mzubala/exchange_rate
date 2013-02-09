# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'exchange_rate/version'

Gem::Specification.new do |gem|
  gem.name = "exchange_rate"
  gem.version = ExchangeRate::VERSION
  gem.authors = ["pwoloszun"]
  gem.email = ["maciej.zubala@gmail.com"]
  gem.description = %q{Exchange rate}
  gem.summary = %q{Exchange rate}
  gem.homepage = ""

  gem.files = `git ls-files`.split($/)
  gem.executables = gem.files.grep(%r{^bin/}).map { |f| File.basename(f) }
  gem.test_files = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]

  gem.add_dependency "activerecord", "~> 3.2.11"
  gem.add_dependency "nokogiri", "~> 1.5.6"

  gem.add_development_dependency "sqlite3"

end
