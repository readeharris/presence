require_relative '../../app/models/reminder_monitor'
require_relative '../../app/models/push_notification'

describe ReminderMonitor do
  it 'allows its interval to be set' do
    reminder_monitor = ReminderMonitor.new(stub)
    reminder_monitor.interval = 10.minutes
    expect(reminder_monitor.interval).to eq(10.minutes)
  end

  describe 'updating interval' do
    it 'increases the interval by 5 minutes if the confirmation status is :confirmed' do
      reminder_monitor = ReminderMonitor.new(stub)
      expect { reminder_monitor.update_interval(:confirmed) }.to change { reminder_monitor.interval }.by(5.minutes)
    end
  end

  context 'if the monitor has never reminded the user' do
    it 'does not remind the user if not enough time has passed since the monitor was created' do
      user = stub
      push_notification = stub_push_notification

      freeze_time do
        reminder_monitor = ReminderMonitor.new(user)
        at_time(30.minutes.from_now - 1.second) { reminder_monitor.remind }
        push_notification.should have_received(:send_to_user).never
      end
    end

    it 'reminds the user if enough time has passed since the monitor was created' do
      user = stub
      push_notification = stub_push_notification

      freeze_time do
        reminder_monitor = ReminderMonitor.new(user)
        at_time(30.minutes.from_now) { reminder_monitor.remind }
        push_notification.should have_received(:send_to_user).once
      end
    end
  end

  context 'if the monitor has previously reminded the user' do
    it 'does not remind the user if not enough time has passed since the last reminder' do
      user = stub
      push_notification = stub_push_notification

      freeze_time do
        reminder_monitor = ReminderMonitor.new(user)

        at_time(30.minutes.from_now) { reminder_monitor.remind }
        at_time(60.minutes.from_now - 1.second) { reminder_monitor.remind }

        push_notification.should have_received(:send_to_user).once
      end
    end

    it 'reminds the user if enough time has passed since the last reminder' do
      user = stub
      push_notification = stub_push_notification

      freeze_time do
        reminder_monitor = ReminderMonitor.new(user)

        at_time(30.minutes.from_now) { reminder_monitor.remind }
        at_time(60.minutes.from_now) { reminder_monitor.remind }

        push_notification.should have_received(:send_to_user).twice
      end
    end
  end

  def stub_push_notification
    stub(:send_to_user).tap do |push_notification|
      PushNotification.stubs(:new).returns(push_notification)
    end
  end
end
