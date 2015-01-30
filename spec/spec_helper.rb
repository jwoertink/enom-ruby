require 'rspec'
require 'vcr'

VCR.configure do |config|
  config.cassette_library_dir = "spec/cassettes"
  config.hook_into :webmock # or :fakeweb
end

RSpec.configure do |c|
  c.extend VCR::RSpec::Macros
end
