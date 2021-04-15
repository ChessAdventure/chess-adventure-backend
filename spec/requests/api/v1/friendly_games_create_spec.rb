require 'rails_helper'

describe 'FriendlyGames create path' do
  describe 'happy' do
    it 'should be able to create a new friendly_game' do
      user = User.create(username: 'John Doe', password: 'Password')
      data = {
        api_key: user.api_key
      }
      headers = { 'CONTENT_TYPE' => 'application/json' }

      post '/api/v1/friendly_games', params: JSON.generate(data), headers: headers

      expect(response.status).to eq(201)

      data = JSON.parse(response.body, symbolize_names: true)[:data]

      expect(FriendlyGame.last.extension).to eq(data[:attributes][:extension])
    end
  end
end