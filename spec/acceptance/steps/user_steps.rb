step 'I am a Presence user' do
  @test_user = User.new

  # Notify observers that the user exists. This is only necessary
  # until persistence is added.
  @test_user.changed
  @test_user.notify_observers(@test_user)
end

step 'I have set a starting interval of :number_of minutes' do |number_of|
  @test_user.reminder_monitor.interval = number_of.minutes
end

step 'I am using the default interval' do
  true #noop
end
