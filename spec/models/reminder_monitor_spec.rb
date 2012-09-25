require_relative '../../app/models/reminder_monitor'
require_relative '../../app/models/push_notification'

describe ReminderMonitor do
  it 'only reminds the user if enough time has passed' do
    user = stub
    reminder_monitor = ReminderMonitor.new(user)

    push_notification = stub(:push_to)
    PushNotification.stubs(:new).returns(push_notification)

    at_time 29.minutes.from_now do
      reminder_monitor.remind
      push_notification.should have_received(:push_to).never
    end

    at_time 31.minutes.from_now do
      reminder_monitor.remind
      push_notification.should have_received(:push_to).with(user).once
    end

    at_time 59.minutes.from_now do
      reminder_monitor.remind
      push_notification.should have_received(:push_to).with(user).once
    end

    at_time 61.minutes.from_now do
      reminder_monitor.remind
      push_notification.should have_received(:push_to).with(user).twice
    end
  end
end

