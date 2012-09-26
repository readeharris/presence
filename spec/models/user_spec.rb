require_relative '../../app/models/user'
require_relative '../../app/models/reminder_monitor'
require_relative '../../app/observers/user_observer'

describe User do
  let(:user) { User.new }

  describe 'reminder monitor' do
    it 'has a reminder monitor by default' do
      user.reminder_monitor.should be_a ReminderMonitor
    end

    it { should delegate(:remind).to(:reminder_monitor) }
  end
end
