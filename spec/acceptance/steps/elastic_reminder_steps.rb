step 'I have set a starting interval of 10 minutes' do
  @test_user.reminder_monitor.interval = 10.minutes
end

step 'the first reminder should occur in 10 minutes' do
  at_time(10.minutes.from_now - 1.second) do
    step 'I should not be reminded'
  end

  at_time(10.minutes.from_now) do
    step 'I should be reminded with a push notification'
  end
end

step 'the next reminder should occur in :number_of minutes' do |number_of|
  at_time(most_recent_reminder.time + number_of.minutes - 1.second) do
    step 'I should not be reminded'
  end

  at_time(most_recent_reminder.time + number_of.minutes) do
    step 'I should be reminded with a push notification'
  end
end

step 'I confirm the most recent reminder' do
  most_recent_reminder.confirm
end
