step 'push notifications are stubbed' do
  @push_notification = stub(:push_to)
  PushNotification.stubs(:new).returns(@push_notification)
end

step 'I am a Presence user' do
  @user = User.new

  # Notify observers that the user exists. This is only necessary
  # until persistence is added.
  @user.changed
  @user.notify_observers(@user)
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

step 'I should be reminded via push notification' do
  expect(@push_notification).to have_received(:push_to).with(@user)
end

step 'I should not be reminded via push notification' do
  expect(@push_notification).to have_received(:push_to).never
end
