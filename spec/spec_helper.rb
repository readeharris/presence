require 'bundler/setup'
require 'active_support/core_ext'
require 'timecop'
require 'bourne'
require 'pry'

Dir["spec/support/**/*.rb"].each    { |f| require File.expand_path(f) }
Dir["spec/acceptance/**/*.rb"].each { |f| require File.expand_path(f) }
Dir["app/models/**/*.rb"].each      { |f| require File.expand_path(f) }
Dir["app/observers/**/*.rb"].each   { |f| require File.expand_path(f) }

RSpec.configure do |config|
  config.mock_with :mocha
  config.order = "random"

  config.include TimeHelpers

  # Global Setup/Teardown
  config.before(:each) do
    UserObserver.forget_users
  end

  config.after(:each) do
    Timecop.return
  end
end
