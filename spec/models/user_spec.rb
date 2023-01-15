require 'rails_helper'

RSpec.describe User, type: :model do
    let(:user1) { User.new(email: 'test3@example.com', password: 'password') }
    let(:user2) { User.new(email: 'test4@example.com', password: 'd') }

  describe 'validations' do
    it { expect(user1).to be_valid}
    it { expect(user2).to_not be_valid }
   
  end
  it "is not valid without an email" do
    user1.email = nil
    expect(subject).to_not be_valid
  end

  it "is not valid without a password" do
    user1.password = nil
    expect(subject).to_not be_valid
  end
  end