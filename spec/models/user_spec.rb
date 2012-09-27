require_relative '../../app/models/user'
require_relative '../../app/models/reminder_monitor'
require_relative '../../app/observers/user_observer'

describe User do
  let(:user) { User.new }

  it 'keeps track of reminders it has received' do
    reminder = stub
    user.add_reminder(reminder)
    expect(user.reminders).to include(reminder)
  end

  describe 'reminder monitor' do
    it 'has a reminder monitor by default' do
      user.reminder_monitor.should be_a ReminderMonitor
    end

    it { should delegate(:remind).to(:reminder_monitor) }
    it { should delegate(:update_interval).to(:reminder_monitor) }
  end
end
