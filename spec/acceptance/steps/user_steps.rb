step 'I am a Presence user' do
  @test_user = User.new

  # Notify observers that the user exists. This is only necessary
  # until persistence is added.
  @test_user.changed
  @test_user.notify_observers(@test_user)
end

step 'I have set a starting interval of 10 minutes' do
  @test_user.reminder_monitor.interval = 10.minutes
end

step 'I am using the default interval' do
  true #noop
end
