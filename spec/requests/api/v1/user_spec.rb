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

      expect(response.status).to eq(201)

      data = JSON.parse(response.body, symbolize_names: true)

      expect(User.last.id).to eq(data[:user][:id])
      expect(data[:user][:username]).to eq('John Doe')
    end

    it 'should show a user, and users' do
      user = User.create(username: 'John Doe', password: 'Password')

      get '/api/v1/users'

      expect(response.status).to eq(200)

      data = JSON.parse(response.body, symbolize_names: true)

      expect(data[:users][0][:id]).to eq(user.id)
      expect(data[:users][0][:username]).to eq(user.username)

      get "/api/v1/users/#{user.id}"

      expect(response.status).to eq(200)

      data = JSON.parse(response.body, symbolize_names: true)

      expect(data[:user][:id]).to eq(user.id)
      expect(data[:user][:username]).to eq(user.username)
    end
  end

  describe 'sad' do
    it 'should not create a user' do
      User.create(username: 'John Doe', password: 'Password')

      data = {
        user: {
          username: 'John Doe',
          password: 'Password',
          password_confirmation: 'Password'
        }
      }
      headers = { 'CONTENT_TYPE' => 'application/json' }

      post '/api/v1/users', params: JSON.generate(data), headers: headers

      expect(response.status).to eq(500)

      data = JSON.parse(response.body, symbolize_names: true)

      expect(data[:errors][0]).to eq("Username has already been taken")

      data = {
        user: {
          username: 'Jane Doe',
          password: 'Pasword',
          password_confirmation: 'Password'
        }
      }
      headers = { 'CONTENT_TYPE' => 'application/json' }

      post '/api/v1/users', params: JSON.generate(data), headers: headers

      expect(response.status).to eq(500)

      data = JSON.parse(response.body, symbolize_names: true)

      expect(data[:errors][0]).to eq("Password confirmation doesn't match Password")
    end
  end
end