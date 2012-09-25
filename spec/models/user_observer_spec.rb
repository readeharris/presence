require_relative '../../app/observers/user_observer'

describe UserObserver do
  it 'keeps track of users it is notified about' do
    users = [stub, stub, stub]
    users.each do |user|
      UserObserver.update(user)
    end
    expect(UserObserver.all_users).to eq(users)
  end

  it "returns an empty array if it isn't keeping track of any users" do
    expect(UserObserver.all_users).to be_empty
  end

  it 'can forget about all users it is tracking' do
    UserObserver.update(stub)
    UserObserver.forget_users
    expect(UserObserver.all_users).to be_empty
  end
end
