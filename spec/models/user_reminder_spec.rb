require_relative '../../app/models/user_reminder'

describe UserReminder do
  it 'can remind any number of given users' do
    users = [stub_everything, stub_everything, stub_everything]

    UserReminder.remind(users)

    users.each do |user|
      expect(user).to have_received(:remind)
    end
  end
end
