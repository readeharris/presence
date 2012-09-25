require_relative '../../app/models/user'
require_relative '../../app/observers/user_observer'
require 'timecop'

describe User do
  let(:user) { User.new }

  it 'knows whether or not it is being monitored' do
    user.should_not be_monitored
    user.monitor = stub
    expect(user).to be_monitored
  end

  it 'can be reminded and knows when it was last reminded' do
    Timecop.freeze(1.day.ago) do
      user.remind!
      expect(user.last_reminded_at).to eq(Time.now)
    end
  end
end
