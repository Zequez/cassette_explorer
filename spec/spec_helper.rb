require 'cassette_explorer'
require 'webmock/rspec'
require 'vcr'
require 'typhoeus'
require 'nokogiri'
require 'capybara/rspec'
require 'capybara/poltergeist'

VCR.configure do |config|
  config.ignore_request do |request|
    host = URI(request.uri).host
    host == '127.0.0.1' || host == 'localhost'
  end

  config.before_record do |i|
    # i.response.body.force_encoding('UTF-8')
  end

  config.preserve_exact_body_bytes do |http_message|
    http_message.body.encoding == Encoding::BINARY ||
    !http_message.body.valid_encoding?
  end

  config.cassette_library_dir = "#{CassetteExplorer::ROOT}/spec/fixtures/vcr_cassettes"
  config.hook_into :webmock # or :fakeweb
  config.configure_rspec_metadata!
end

Capybara.configure do |config|
  config.run_server = false
  config.default_driver = :selenium
  config.app_host = 'http://localhost:2332' # change url
end


# See http://rubydoc.info/gems/rspec-core/RSpec/Core/Configuration
RSpec.configure do |config|
  # rspec-expectations config goes here. You can use an alternate
  # assertion/expectation library such as wrong or the stdlib/minitest
  # assertions if you prefer.
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  # rspec-mocks config goes here. You can use an alternate test double
  # library (such as bogus or mocha) by changing the `mock_with` option here.
  config.mock_with :rspec do |mocks|
    # Prevents you from mocking or stubbing a method that does not exist on
    # a real object. This is generally recommended, and will default to
    # `true` in RSpec 4.
    mocks.verify_partial_doubles = true
  end
end
