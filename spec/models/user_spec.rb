require 'rails_helper'

describe User, type: :model do
  describe 'create user' do
    it 'should create a user' do
      user = User.create!(username: 'JohnDoe', password: '123456')

      expect(User.first.username).to eq(user.username)
      expect(User.first.api_key).not_to be(nil)
    end
  end

  describe 'instance methods' do
    it 'can return the most recent completed game' do
      user = User.create!(username: 'JohnDoe', password: '123456')
      user2 = User.create!(username: 'JaneDoe', password: '123')
      game = FriendlyGame.create!(starting_fen: 'rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR w KQkq - 0 1', white_id: user.id, black_id: user2.id, status: 3)
      game2 = FriendlyGame.create!(starting_fen: 'rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR w KQkq - 0 1', white_id: user.id, black_id: user2.id, status: 3)
      game3 = FriendlyGame.create!(starting_fen: 'rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR w KQkq - 0 1', white_id: user.id, black_id: user2.id, status: 0)

      expect(user.last_game).to eq(game2)
      expect(user2.last_game).to eq(game2)
    end

    it 'can tell white win/lose ratio' do
      user = User.create!(username: 'JohnDoe', password: '123456')
      user2 = User.create!(username: 'JaneDoe', password: '123')
      game = FriendlyGame.create!(starting_fen: 'rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR w KQkq - 0 1', white_id: user.id, black_id: user2.id, status: 1)
      game2 = FriendlyGame.create!(starting_fen: 'rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR w KQkq - 0 1', white_id: user.id, black_id: user2.id, status: 2)
      game3 = FriendlyGame.create!(starting_fen: 'rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR w KQkq - 0 1', white_id: user.id, black_id: user2.id, status: 3)
      game4 = FriendlyGame.create!(starting_fen: 'rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR w KQkq - 0 1', white_id: user.id, black_id: user2.id, status: 0)

      expect(user.friendly_ratio).to eq('1-1')
    end

    it 'can tell the longest win streak' do

    end
  end
end