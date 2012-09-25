require 'active_support/core_ext'

class UserObserver
  class << self
    def update(user)
      keep_track_of(user)
    end

    def keep_track_of(user)
      all_users << user
    end

    def all_users
      @@all_users ||= []
    end

    def forget_users
      all_users.clear
    end
  end
end
