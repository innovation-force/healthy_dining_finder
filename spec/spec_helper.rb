ENV["RAILS_ENV"] = "test"
require 'bundler/setup'
require 'healthy_dining_finder' # and any other gems you need
require 'vcr'
require 'webmock/rspec'
Bundler.setup

RSpec.configure do |config| 
  # rspec-expectations config goes here.
  config.expect_with :rspec do |expectations|
    # This option makes the `description` and `failure_message` of custom matchers include text for helper methods defined using `chain`.
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  # rspec-mocks config goes here.
  config.mock_with :rspec do |mocks|
    # Prevents you from mocking or stubbing a method that does not exist on a real object.
    mocks.verify_partial_doubles = true
  end

  # Limits the available syntax to the non-monkey patched syntax that is recommended.
  config.disable_monkey_patching!
end

VCR.configure do |config|
  config.cassette_library_dir = 'spec/cassettes'
  config.hook_into :webmock
  config.configure_rspec_metadata!
end
