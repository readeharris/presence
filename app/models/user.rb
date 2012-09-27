require 'observer'

class User
  include Observable

  attr_reader :reminder_monitor

  def initialize
    @reminder_monitor = ReminderMonitor.new(self)
    add_observer UserObserver
  end

  def remind
    reminder_monitor.remind
  end

  def add_reminder(reminder)
    reminders << reminder
  end

  def reminders
    @reminders ||= []
  end

  def update_interval(*args, &block)
    reminder_monitor.update_interval(*args, &block)
  end
end
