step 'the reminder job runs' do
  UserReminder.remind(UserObserver.all_users)
end

step 'I should not be reminded' do
  expect { step 'the reminder job runs' }.not_to change { @test_user.reminders.count }
end

step 'I should be reminded with a push notification' do
  expect { step 'the reminder job runs' }.to change { @test_user.reminders.count }.by(1)
  expect(most_recent_reminder).to be_a PushNotification
end

step 'the first reminder should occur in :number_of minutes' do |number_of|
  at_time(number_of.minutes.from_now - 1.second) do
    step 'I should not be reminded'
  end

  at_time(number_of.minutes.from_now) do
    step 'I should be reminded with a push notification'
  end
end

step 'the next reminder should (still) occur in :number_of minutes' do |number_of|
  at_time(most_recent_reminder.time + number_of.minutes - 1.second) do
    step 'I should not be reminded'
  end

  at_time(most_recent_reminder.time + number_of.minutes) do
    step 'I should be reminded with a push notification'
  end
end

step 'I report being aware (again)' do
  most_recent_reminder.confirm
end

step 'I report being unaware (again)' do
  most_recent_reminder.deny
end
