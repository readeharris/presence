step 'I am a Presence user' do
  @user = User.new

  # Notify observers that the user exists. This is only necessary
  # until persistence is added.
  @user.changed
  @user.notify_observers(@user)
end

step 'I am monitoring my awareness' do
  @user.monitor = Monitor.new
end

step '30 minutes pass' do
  @current_time = 30.minutes.from_now
end

step 'the reminder job runs' do
  Timecop.freeze(@current_time) do
    UserReminder.remind!(UserObserver.all_users)
  end
end

step 'I should be reminded' do
  expect(@user.last_reminded_at.to_i).to eq(@current_time.to_i)
end
