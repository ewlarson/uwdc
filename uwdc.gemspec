# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'uwdc/version'

Gem::Specification.new do |gem|
  gem.name          = "uwdc"
  gem.version       = UWDC::VERSION
  gem.authors       = ["Eric Larson"]
  gem.email         = ["ewlarson@gmail.com"]
  gem.description   = %q{Gem for the University of Wisconsin Digital Collections}
  gem.summary       = %q{Use the UWDC collections}
  gem.homepage      = "https://github.com/ewlarson/uwdc"
  
  gem.add_dependency 'httpclient'
  gem.add_dependency 'nokogiri'
  gem.add_dependency 'json'
  gem.add_dependency 'active_support'

  gem.add_development_dependency 'rake'
  gem.add_development_dependency 'rspec'

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]
end