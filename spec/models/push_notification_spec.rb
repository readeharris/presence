describe PushNotification do
  it 'keeps track of the time it was initialized' do
    freeze_time do
      push_notification = PushNotification.new(stub)
      expect(push_notification.time).to eq(Time.now)
    end
  end

  describe 'delivering' do
    it "adds itself to the user's reminders" do
      user = stub(:add_reminder)
      push_notification = PushNotification.new(user)
      push_notification.deliver
      expect(user).to have_received(:add_reminder).with(push_notification)
    end
  end

  describe 'confirmation status' do
    it 'is :no_response by default' do
      notification = PushNotification.new(stub)
      expect(notification.confirmation_status).to eq(:no_response)
    end

    it 'can be confirmed' do
      user = stub_everything
      notification = PushNotification.new(user)
      notification.confirm
      expect(notification).to be_confirmed
    end
  end

  it "updates the user's interval with its confirmation status when it is confirmed" do
    user = stub(:update_interval)
    notification = PushNotification.new(user)

    notification.confirm

    expect(user).to have_received(:update_interval).with(:confirmed)
  end
end
