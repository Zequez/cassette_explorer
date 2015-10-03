# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'cassette_explorer/version'

Gem::Specification.new do |spec|
  spec.name          = 'cassette_explorer'
  spec.version       = CassetteExplorer::VERSION
  spec.authors       = ['Zequez']
  spec.email         = ['zequez@gmail.com']
  spec.summary       = %q{VCR Cassette Explorer}
  spec.description   = %q{Mounts a webserver to serve VCR cassettes for visualization on your browser}
  spec.homepage      = 'http://github.com/Zequez/cassette_explorer'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = 'cassette_explorer'
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_dependency 'listen', '~> 3.0'

  spec.add_development_dependency 'bundler', '~> 1.7'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec', '~> 3.3'
  spec.add_development_dependency 'guard', '~> 2.13'
  spec.add_development_dependency 'guard-rspec', '~> 4.6'
  spec.add_development_dependency 'webmock', '~> 1.21'
  spec.add_development_dependency 'vcr', '~> 2.9'
  spec.add_development_dependency 'typhoeus', '~> 0.7'
  spec.add_development_dependency 'nokogiri', '~> 1.6'
  spec.add_development_dependency 'capybara', '~> 2.4'
  spec.add_development_dependency 'selenium-webdriver', '~> 2.46'
  spec.add_development_dependency 'poltergeist', '~> 1.6'
end
