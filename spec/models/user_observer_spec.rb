require 'spec_helper_lite'
require_relative '../../app/observers/user_observer'

describe UserObserver do
  it 'keeps track of users it is notified about' do
    user = stub
    UserObserver.update(user)
    expect(UserObserver.all_users).to include(user)
  end

  it 'can keep track of any number of users' do
    users = [stub, stub, stub]
    users.each do |user|
      UserObserver.keep_track_of(user)
    end
    expect(UserObserver.all_users).to eq(users)
  end

  it "returns an empty array if it isn't keeping track of any users" do
    expect(UserObserver.all_users).to be_empty
  end

  it 'can forget about all users it is tracking' do
    UserObserver.keep_track_of(stub)
    UserObserver.forget_users
    expect(UserObserver.all_users).to be_empty
  end
end
