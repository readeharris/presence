step 'I am a Presence user' do
  @test_user = User.new

  # Notify observers that the user exists. This is only necessary
  # until persistence is added.
  @test_user.changed
  @test_user.notify_observers(@test_user)
end

step 'I am using the default interval' do
  true #noop
end

step ':number_of minutes pass' do |number_of|
  Timecop.travel(number_of.minutes.from_now)
end

step 'the reminder job runs' do
  UserReminder.remind(UserObserver.all_users)
end

step 'I should be reminded with a push notification' do
  expect { step 'the reminder job runs' }.to change { @test_user.reminders.count }.by(1)
  expect(most_recent_reminder).to be_a PushNotification
end

step 'I should not be reminded' do
  expect { step 'the reminder job runs' }.not_to change { @test_user.reminders.count }
end
