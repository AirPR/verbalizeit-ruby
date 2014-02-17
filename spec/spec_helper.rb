require "rubygems"
require "bundler/setup"
require "vcr"
require "verbalizeit"

RSpec.configure do |config|
  # all defaults so far
end

VCR.configure do |c|
  c.cassette_library_dir = 'spec/fixtures/cassettes'
  c.hook_into :webmock
  c.default_cassette_options = {
    :match_requests_on => [
                           :method,
                           VCR.request_matchers.uri_without_param(:auth_token)
                          ]
  }
end
