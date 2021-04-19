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
    it 'should be able to update a friendly_game' do
      user = User.create(username: 'John Doe', password: 'Password')
      user_data = {
        api_key: user.api_key
      }
      headers = { 'CONTENT_TYPE' => 'application/json' }

      post '/api/v1/friendly_games', params: JSON.generate(user_data), headers: headers

      game = FriendlyGame.last
      game.white_id = user.id
      game.save

      game_params = {
        fen: "rnbqkbnr/pppppppp/8/8/3P4/8/PPP1PPPP/RNBQKBNR w KQkq - 0 1",
        extension: game.extension,
        status: game.status,
        api_key: user.api_key
      }

      patch '/api/v1/friendly_games', params: JSON.generate(game_params), headers: headers

      expect(response.status).to eq(200)
      expect(response.body.include?("get it together chris")).to eq(true)
    end
  end
  describe 'sad' do
    it 'should not create a new friendly_game if user is not logged in' do
      headers = { 'CONTENT_TYPE' => 'application/json' }

      post '/api/v1/friendly_games', headers: headers

      expect(response.status).to eq(500)

      data = JSON.parse(response.body, symbolize_names: true)[:data]

      expect(data).to eq(nil)
    end
    it 'should not update a friendly_game if attributes are missing' do
      user = User.create(username: 'John Doe', password: 'Password')
      user_data = {
        api_key: user.api_key
      }
      headers = { 'CONTENT_TYPE' => 'application/json' }

      post '/api/v1/friendly_games', params: JSON.generate(user_data), headers: headers

      game = FriendlyGame.last
      game.white_id = user.id
      game.save

      game_data = JSON.parse(response.body, symbolize_names: true)[:data]

      game_params = {
        status: game.status,
        api_key: user.api_key
      }

      patch '/api/v1/friendly_games', params: JSON.generate(game_params), headers: headers

      expect(response.status).to eq(501)
    end
    it 'should not update a friendly_game if its not players turn' do
      user = User.create(username: 'John Doe', password: 'Password')
      user_data = {
        api_key: user.api_key
      }
      headers = { 'CONTENT_TYPE' => 'application/json' }

      post '/api/v1/friendly_games', params: JSON.generate(user_data), headers: headers

      game = FriendlyGame.last
      game.white_id = user.id
      game.save
      game_data = JSON.parse(response.body, symbolize_names: true)[:data]

      game_params = {
        fen: 'rnbqkbnr/pppppppp/8/8/8/8/PPPPPPP/RNBQKBNR w KQkq - 0 1\"}}}',
        extension: game_data[:attributes][:extension],
        status: game.status,
        api_key: user.api_key
      }
      game_params2 = {
        fen: 'rnbqkbnr/pppppppp/8/8/8/8/PPPPPPP/RNBQKBNR b KQkq - 0 1\"}}}',
        extension: game_data[:attributes][:extension],
        status: game.status,
        api_key: user.api_key
      }

      patch '/api/v1/friendly_games', params: JSON.generate(game_params), headers: headers
      patch '/api/v1/friendly_games', params: JSON.generate(game_params2), headers: headers

      expect(response.status).to eq(501)
      # expect(response.body.include?("It's not your turn")).to eq(true)
    end
    it 'should not update a friendly_game if player does not own piece' do
      user = User.create(username: 'John Doe', password: 'Password')
      user_data = {
        api_key: user.api_key
      }
      headers = { 'CONTENT_TYPE' => 'application/json' }

      post '/api/v1/friendly_games', params: JSON.generate(user_data), headers: headers

      game = FriendlyGame.last
      game.white_id = user.id
      game.save
      game_data = JSON.parse(response.body, symbolize_names: true)[:data]

      game_params = {
        fen: "rnbqkbnr/p1pppppp/8/1p6/4P3/5P2/PPPP1PPP/RNBQKBNR w KQkq - 0 1",
        extension: game_data[:attributes][:extension],
        status: game.status,
        api_key: user.api_key
      }

      patch '/api/v1/friendly_games', params: JSON.generate(game_params), headers: headers

      expect(response.status).to eq(501)
      expect(response.body.include?("Not yours to move")).to eq(true)
    end
  end
end
