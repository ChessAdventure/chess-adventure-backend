require 'rails_helper'

describe 'Stats paths' do
  describe 'happy' do
    it 'should return a users stats' do
      user = User.create!(username: 'JohnDoe', password: '123456')
      user2 = User.create!(username: 'JaneDoe', password: '123')
      game = FriendlyGame.create!(starting_fen: 'rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR w KQkq - 0 1', white_id: user.id, black_id: user2.id, status: 3)
      game2 = FriendlyGame.create!(starting_fen: 'rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR w KQkq - 0 1', white_id: user.id, black_id: user2.id, status: 3)
      game3 = FriendlyGame.create!(starting_fen: 'rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR w KQkq - 0 1', white_id: user.id, black_id: user2.id, status: 0)

      data = {}
      headers = { 'CONTENT_TYPE' => 'application/json' }

      get "/api/v1/stats/#{user.username}", params: JSON.generate(data), headers: headers

      expect(response.status).to eq(200)

      data = JSON.parse(response.body, symbolize_names: true)[:data][:meta][:last_game]

      expect(data[:white]).to eq(user.username)
      expect(data[:black]).to eq(user2.username)
      expect(data[:status]).to eq(game2.status)
      expect(data[:fen]).to eq(game2.current_fen)
    end
  end

  describe 'sad' do
    it 'invalid username' do
      user = User.create!(username: 'JohnDoe', password: '123456')
      user2 = User.create!(username: 'JaneDoe', password: '123')
      game = FriendlyGame.create!(starting_fen: 'rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR w KQkq - 0 1', white_id: user.id, black_id: user2.id, status: 3)
      game2 = FriendlyGame.create!(starting_fen: 'rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR w KQkq - 0 1', white_id: user.id, black_id: user2.id, status: 3)
      game3 = FriendlyGame.create!(starting_fen: 'rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR w KQkq - 0 1', white_id: user.id, black_id: user2.id, status: 0)

      data = {}
      headers = { 'CONTENT_TYPE' => 'application/json' }

      get "/api/v1/stats/#{user.username + 'nonsense'}", params: JSON.generate(data), headers: headers

      expect(response.status).to eq(404)

      data = JSON.parse(response.body, symbolize_names: true)[:error][0]

      expect(data).to eq('No user found')
    end
  end
end