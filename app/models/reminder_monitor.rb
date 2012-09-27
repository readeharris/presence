class ReminderMonitor
  attr_accessor :interval

  def initialize(user)
    @user = user
    @created_at = Time.now
    @interval = 30.minutes
    @last_reminded_at = nil
  end

  def remind
    if time_to_remind?
      send_push_notification_to_user
      update_last_reminded_time
    end
  end

  def update_interval(confirmation_status)
    case confirmation_status
    when :confirmed then @interval += 5.minutes
    when :denied then @interval -= 5.minutes
    end
  end

  private

  def send_push_notification_to_user
    PushNotification.new(@user).deliver
  end

  def update_last_reminded_time
    @last_reminded_at = Time.now
  end

  def time_to_remind?
    if ever_reminded?
      interval_passed_since_last_reminded?
    else
      interval_passed_since_created?
    end
  end

  def ever_reminded?
    @last_reminded_at.present?
  end

  def interval_passed_since_last_reminded?
    Time.now >= (@last_reminded_at + @interval)
  end

  def interval_passed_since_created?
    Time.now >= (@created_at + @interval)
  end
end
