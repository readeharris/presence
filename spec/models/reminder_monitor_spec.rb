require_relative '../../app/models/reminder_monitor'
require_relative '../../app/models/push_notification'

describe ReminderMonitor do
  it 'allows its interval to be set' do
    reminder_monitor = ReminderMonitor.new(stub)

    reminder_monitor.interval = 10.minutes

    expect(reminder_monitor.interval).to eq(10.minutes)
  end

  describe 'updating interval' do
    it 'increases the interval by 5 minutes if given a confirmation status of :confirmed' do
      reminder_monitor = ReminderMonitor.new(stub)
      expect { reminder_monitor.update_interval(:confirmed) }.to change { reminder_monitor.interval }.by(5.minutes)
    end

    it 'decreases the interval by 5 minutes if given a confirmation status of :denied' do
      reminder_monitor = ReminderMonitor.new(stub)
      expect { reminder_monitor.update_interval(:denied) }.to change { reminder_monitor.interval }.by(-5.minutes)
    end

    it 'does not decrease the interval below 5 minutes' do
      reminder_monitor = ReminderMonitor.new(stub)
      reminder_monitor.interval = 5.minutes

      reminder_monitor.update_interval(:denied)

      expect(reminder_monitor.interval).to eq(5.minutes)
    end
  end

  context 'if the monitor has never reminded the user' do
    it 'does not remind the user if not enough time has passed since the monitor was created' do
      freeze_time do
        user = stub
        push_notification = stub_push_notification
        reminder_monitor = ReminderMonitor.new(user)

        at_time(30.minutes.from_now - 1.second) { reminder_monitor.remind }

        push_notification.should have_received(:deliver).never
      end
    end

    it 'reminds the user if enough time has passed since the monitor was created' do
      freeze_time do
        user = stub
        push_notification = stub_push_notification
        reminder_monitor = ReminderMonitor.new(user)

        at_time(30.minutes.from_now) { reminder_monitor.remind }

        push_notification.should have_received(:deliver).once
      end
    end
  end

  context 'if the monitor has previously reminded the user' do
    it 'does not remind the user if not enough time has passed since the last reminder' do
      freeze_time do
        user = stub
        push_notification = stub_push_notification
        reminder_monitor = ReminderMonitor.new(user)

        at_time(30.minutes.from_now)            { reminder_monitor.remind }
        at_time(60.minutes.from_now - 1.second) { reminder_monitor.remind }

        push_notification.should have_received(:deliver).once
      end
    end

    it 'reminds the user if enough time has passed since the last reminder' do
      freeze_time do
        user = stub
        push_notification = stub_push_notification
        reminder_monitor = ReminderMonitor.new(user)

        at_time(30.minutes.from_now) { reminder_monitor.remind }
        at_time(60.minutes.from_now) { reminder_monitor.remind }

        push_notification.should have_received(:deliver).twice
      end
    end
  end

  def stub_push_notification
    stub(:deliver).tap do |push_notification|
      PushNotification.stubs(:new).returns(push_notification)
    end
  end
end
