require_relative '../../app/models/user_reminder'

describe UserReminder do
  describe '.remind_users' do
    it 'reminds the given users' do
      users = [stub.as_null_object, stub.as_null_object, stub.as_null_object]
      UserReminder.remind!(users)

      users.each do |user|
        expect(user).to have_received(:remind!)
      end
    end
  end
end
