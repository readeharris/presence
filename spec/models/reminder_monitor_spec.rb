require_relative '../../app/models/reminder_monitor'
require_relative '../../app/models/push_notification'

describe ReminderMonitor do
  context 'if the monitor has never reminded the user' do
    it 'does not remind the user if not enough time has passed since the monitor was created' do
      user = stub
      reminder_monitor = ReminderMonitor.new(user)
      push_notification = stub_push_notification

      at_time(29.minutes.from_now) { reminder_monitor.remind }

      push_notification.should have_received(:push_to).never
    end

    it 'reminds the user if enough time has passed since the monitor was created' do
      user = stub
      reminder_monitor = ReminderMonitor.new(user)
      push_notification = stub_push_notification

      at_time(31.minutes.from_now) { reminder_monitor.remind }

      push_notification.should have_received(:push_to).with(user).once
    end
  end

  context 'if the monitor has previously reminded the user' do
    it 'does not remind the user if not enough time has passed since the last reminder' do
      user = stub
      reminder_monitor = ReminderMonitor.new(user)
      push_notification = stub_push_notification

      at_time(31.minutes.from_now) { reminder_monitor.remind }
      at_time(59.minutes.from_now) { reminder_monitor.remind }

      push_notification.should have_received(:push_to).with(user).once
    end

    it 'reminds the user if enough time has passed since the last reminder' do
      user = stub
      reminder_monitor = ReminderMonitor.new(user)
      push_notification = stub_push_notification

      at_time(31.minutes.from_now) { reminder_monitor.remind }
      at_time(61.minutes.from_now) { reminder_monitor.remind }

      push_notification.should have_received(:push_to).with(user).twice
    end
  end

  def stub_push_notification
    stub(:push_to).tap do |push_notification|
      PushNotification.stubs(:new).returns(push_notification)
    end
  end
end
