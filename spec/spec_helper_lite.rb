require 'capybara/rspec'
require 'turnip/capybara'

Dir[File.dirname(__FILE__).concat('/support/**/*.rb')].each { |f| require f }
Dir[File.dirname(__FILE__).concat('/acceptance/**/*.rb')].each { |f| require f }

RSpec.configure do |config|
  # Run specs in random order to surface order dependencies. If you find an
  # order dependency and want to debug it, you can fix the order by providing
  # the seed, which is printed after each run.
  #     --seed 1234
  config.order = "random"
end

RSpec.configure do |config|
  config.before(:each) do
    UserObserver.forget_users
  end
end
