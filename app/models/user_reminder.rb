class UserReminder
  def self.remind!(users)
    users.each do |user|
      user.remind!
    end
  end
end
