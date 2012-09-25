class UserObserver
  class << self
    def update(user)
      keep_track_of(user)
    end

    def forget_users
      all_users.clear
    end

    def all_users
      @@all_users ||= []
    end

    private

    def keep_track_of(user)
      all_users << user
    end
  end
end
