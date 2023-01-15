require 'rails_helper'

RSpec.describe Record, type: :model do
    user= User.create(email: 'test1@example.com', password: 'password',id:1)
    let(:record1) { Record.new(name: 'Who is gedeon?', user_id: user.id) }
    let(:record2) { Record.new(name: 'What is a banana?') }

  describe 'validations' do
    it { expect(record1).to be_valid}
  end
  it "is not valid without an id" do
     expect(record2).to_not be_valid 
  end

  it "is not valid without a name" do
    record2.name = nil
    expect(subject).to_not be_valid
  end
  end