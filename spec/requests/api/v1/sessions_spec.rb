require 'rails_helper'

describe 'User paths' do
  describe 'happy' do
    it "should be able to login" do
      user = User.create(username: 'John Doe', password: 'Password')

      data = {
        user: {
          username: 'John Doe',
          password: 'Password',
          password_confirmation: 'Password'
        }
      }
      headers = { 'CONTENT_TYPE' => 'application/json' }

      post '/api/v1/login', params: JSON.generate(data), headers: headers

      expect(response.status).to eq(200)

      data = JSON.parse(response.body, symbolize_names: true)

      expect(data[:user][:username]).to eq(user.username)
      expect(data[:user][:id]).to eq(user.id)
    end
  end

  describe 'sad' do

  end
end