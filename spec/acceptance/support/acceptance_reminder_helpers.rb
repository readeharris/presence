module AcceptanceHelpers
  module ReminderHelpers
    def most_recent_reminder
      @test_user.reminders.last
    end
  end
end
