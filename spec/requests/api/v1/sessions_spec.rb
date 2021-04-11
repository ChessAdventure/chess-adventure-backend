require 'rails_helper'

describe 'User paths' do
  describe 'happy' do
    it 'should be able to login' do
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

      data = JSON.parse(response.body, symbolize_names: true)[:data]

      expect(User.last.api_key).to eq(data[:attributes][:api_key])
      expect(data[:attributes][:username]).to eq(user.username)
    end
  end

  describe 'sad' do
    it 'should not find user not there' do
    # not adding user before hand
    # should create user but have no data?
      data = {
        user: {
          username: 'John Doe',
          password: 'Password',
          password_confirmation: 'Password'
        }
      }

      headers = { 'CONTENT_TYPE' => 'application/json' }

      post '/api/v1/login', params: JSON.generate(data), headers: headers

      expect(response.status).to eq(401)

      data = JSON.parse(response.body, symbolize_names: true)

      expect(data[:errors][0]).to eq('no such user, please try again')
    end
  end

end
