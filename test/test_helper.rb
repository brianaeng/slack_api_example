ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
require 'minitest/reporters'
# Order matters here?
require 'vcr'
require 'webmock/minitest'

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all
  Minitest::Reporters.use!

  # Add more helper methods to be used by all tests here...
  VCR.configure do |config|
    config.cassette_library_dir = 'test/cassettes' # folder where casettes will be located (these will be reused unless they're deleted/replaced)
    config.hook_into :webmock # tie into this other tool called webmock (VCR can use other mocking gems) - this pretends to be the internet
    config.default_cassette_options = {
      :record => :new_episodes,    # record new data when we don't have it yet
      :match_requests_on => [:method, :uri, :body] # The http method, URI and body of a request all need to match (or else it will record something new)
    }
  end
end
