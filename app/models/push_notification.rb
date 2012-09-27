class PushNotification
  attr_reader :time, :confirmation_status

  def initialize(user)
    @user = user
    @time = Time.now
    @confirmation_status = :no_response
  end

  def deliver
    @user.add_reminder(self)
  end

  def confirm
    @confirmation_status = :confirmed
    update_user_interval
  end

  def deny
    @confirmation_status = :denied
    update_user_interval
  end

  private

  def update_user_interval
    @user.update_interval(@confirmation_status)
  end
end
