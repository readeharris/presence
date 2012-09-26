class PushNotification
  attr_reader :time, :confirmation_status

  def initialize(user)
    @user = user
    @time = Time.now
    @confirmation_status = :no_response
  end

  def send_to_user
    @user.add_reminder(self)
  end

  def confirm
    @confirmation_status = :confirmed
    @user.update_interval(@confirmation_status)
  end

  def confirmed?
    @confirmation_status == :confirmed
  end
end
