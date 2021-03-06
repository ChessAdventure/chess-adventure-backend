require 'rails_helper'

describe 'User paths' do
  describe 'logging in' do 
    describe 'happy' do
      it 'should be able to login' do
        user = User.create(username: 'JohnDoe', password: 'Password')

        data = {
          user: {
            username: 'JohnDoe',
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
        user = User.create(username: 'JohnDoe', password: 'Password')

        data = {
          user: {
            username: '',
            password: '',
            password_confirmation: ''
          }
        }

        headers = { 'CONTENT_TYPE' => 'application/json' }

        post '/api/v1/login', params: JSON.generate(data), headers: headers

        expect(response.status).to eq(401)

        data = JSON.parse(response.body, symbolize_names: true)

        expect(data[:errors][0]).to eq('no such user, please try again')
      end

      it 'should not login with incorrect password' do
        user = User.create(username: 'JohnDoe', password: 'Password')

        data = {
          user: {
            username: 'JohnDoe',
            password: 'WrongPassword',
            password_confirmation: 'WrongPassword'
          }
        }

        headers = { 'CONTENT_TYPE' => 'application/json' }

        post '/api/v1/login', params: JSON.generate(data), headers: headers

        expect(response.status).to eq(401)

        data = JSON.parse(response.body, symbolize_names: true)[:errors][0]

        expect(data).to eq('no such user, please try again')
      end

      it 'should not login with missing username' do
        user = User.create(username: 'JohnDoe', password: 'Password')

        data = {
          user: {
            username: '',
            password: 'Password',
            password_confirmation: 'Password'
          }
        }

        headers = { 'CONTENT_TYPE' => 'application/json' }

        post '/api/v1/login', params: JSON.generate(data), headers: headers

        expect(response.status).to eq(401)

        data = JSON.parse(response.body, symbolize_names: true)[:errors][0]

        expect(data).to eq('no such user, please try again')
      end

      it 'should not login with mismatched password' do
        user = User.create(username: 'JohnDoe', password: 'smth', 
          password_confirmation: 'smth_else')

        data = {
          user: {
            username: 'JohnDoe',
            password: 'smth',
            password_confirmation: 'smth_else'
          }
        }

        headers = { 'CONTENT_TYPE' => 'application/json' }

        post '/api/v1/login', params: JSON.generate(data), headers: headers

        expect(response.status).to eq(401)

        data = JSON.parse(response.body, symbolize_names: true)[:errors][0]

        expect(data).to eq('no such user, please try again')
      end
    end
  end

  describe 'user is logged in method' do
    describe 'happy' do
      it 'should be able to login' do
        user = User.create(username: 'JohnDoe', password: 'Password')

        data = {
          user: {
            username: 'JohnDoe',
            password: 'Password',
            password_confirmation: 'Password'
          }
        }
        headers = { 'CONTENT_TYPE' => 'application/json' }

        post '/api/v1/login', params: JSON.generate(data), headers: headers

        get '/api/v1/logged_in', params: JSON.generate(data), headers: headers

        data = JSON.parse(response.body, symbolize_names: true)

        expect(response.status).to eq(200)
        expect(data[:logged_in]).to eq(true)
        expect(data[:user][:username]).to eq(user.username)
      end
    end

    describe 'sad' do
      it 'should recognize not logged in' do
        data = {
          user: {
            username: '',
            password: '',
            password_confirmation: ''
          }
        }
        headers = { 'CONTENT_TYPE' => 'application/json' }

        get '/api/v1/logged_in', params: JSON.generate(data), headers: headers

        data = JSON.parse(response.body, symbolize_names: true)

        expect(response.status).to eq(401)
        expect(data[:logged_in]).to eq(false)
        expect(data[:message]).to eq('no such user')
      end
    end
  end

  describe 'logout' do
    describe 'happy' do
      it 'a user can log out when logged in' do
        user = User.create(username: 'JohnDoe', password: 'Password')

        data = {
          user: {
            username: 'JohnDoe',
            password: 'Password',
            password_confirmation: 'Password'
          }
        }
        headers = { 'CONTENT_TYPE' => 'application/json' }

        post '/api/v1/login', params: JSON.generate(data), headers: headers

        expect(response.status).to eq(200)

        get '/api/v1/logged_in', params: JSON.generate(data), headers: headers

        expect(response.status).to eq(200)

        data = JSON.parse(response.body, symbolize_names: true)

        expect(data[:logged_in]).to eq(true)

        post '/api/v1/logout', params: JSON.generate(data), headers: headers

        expect(response.status).to eq(200)
      end
    end

    describe 'sad' do
      it 'should not logout if not logged in' do
        user = User.create(username: 'JohnDoe', password: 'Password')

        data = {
          user: {
            username: 'JohnDoe',
            password: 'Password',
            password_confirmation: 'Password'
          }
        }
        headers = { 'CONTENT_TYPE' => 'application/json' }

        get '/api/v1/logged_in', params: JSON.generate(data), headers: headers

        expect(response.status).to eq(401)

        data = JSON.parse(response.body, symbolize_names: true)

        expect(data[:logged_in]).to eq(false)

        post '/api/v1/logout', params: JSON.generate(data), headers: headers

        data = JSON.parse(response.body, symbolize_names: true)

        expect(response.status).to eq(401)
        expect(data[:logged_out]).to eq(false)
        expect(data[:message]).to eq('log out unsuccessful')
      end
    end
  end

end
