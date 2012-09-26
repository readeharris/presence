class UserReminder
  def self.remind(users)
    users.each(&:remind)
  end
end
