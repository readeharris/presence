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
end
