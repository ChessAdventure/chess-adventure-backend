require 'rails_helper'

describe 'User paths' do
  describe 'happy' do
    it 'should create a user' do
      data = {
        user: {
          username: 'John Doe',
          password: 'Password',
          password_confirmation: 'Password'
        }
      }
      headers = { 'CONTENT_TYPE' => 'application/json' }

      post '/api/v1/users', params: JSON.generate(data), headers: headers

      expect(response.status).to eq(200)

      data = JSON.parse(response.body, symbolize_names: true)

      expect(User.last.id).to eq(data[:user][:id])
      expect(data[:user][:username]).to eq('John Doe')
    end
  end
end