class UserObserver
  def self.update(user)
    keep_track_of(user)
  end

  def self.forget_users
    all_users.clear
  end

  def self.all_users
    @@all_users ||= []
  end

  private

  def self.keep_track_of(user)
    all_users << user
  end
end
