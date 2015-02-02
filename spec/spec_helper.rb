require 'rspec'
require 'vcr'
require 'dotenv'
Dotenv.load

$: << File.expand_path('../lib', __FILE__)
require 'enom-ruby'

real_requests = ENV['REAL_REQUESTS']

VCR.configure do |config|
  config.cassette_library_dir = "spec/cassettes"
  config.hook_into :webmock
  config.configure_rspec_metadata!
  config.allow_http_connections_when_no_cassette = true if real_requests
  config.default_cassette_options = {record: :new_episodes}
end

RSpec.configure do |config|
  config.filter_run_including focus: true

  config.before(:each) {
    VCR.eject_cassette
  } if real_requests
end

EnomRuby::Client.configure do |config|
  config.username = ENV['ENOM_USERNAME']
  config.password = ENV['ENOM_PASSWORD']
  config.test_mode = true
end
