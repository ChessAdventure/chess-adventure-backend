require 'rails_helper'

describe User, type: :model do
  describe 'create user' do
    it 'should create a user' do
      user = User.create!(username: 'John Doe', password: '123456')

      expect(User.first.username).to eq(user.username)
      expect(User.first.api_key).not_to be(nil)
    end
  end
end