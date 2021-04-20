require 'rails_helper'

describe User, type: :model do
  describe 'create user' do
    it 'should create a user' do
      user = User.create!(username: 'John Doe', password: '123456')

      expect(User.first.username).to eq(user.username)
      expect(User.first.api_key).not_to be(nil)
    end
  end

  describe 'instance methods' do
    it 'can return the most recent completed game' do
      user = User.create!(username: 'John Doe', password: '123456')
      user2 = User.create!(username: 'Jane Doe', password: '123')
      game = FriendlyGame.create!(starting_fen: 'rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR w KQkq - 0 1', white_id: user.id, black_id: user2.id, status: 3)
      game2 = FriendlyGame.create!(starting_fen: 'rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR w KQkq - 0 1', white_id: user.id, black_id: user2.id, status: 3)
      game3 = FriendlyGame.create!(starting_fen: 'rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR w KQkq - 0 1', white_id: user.id, black_id: user2.id, status: 0)

      expect(user.last_game).to be game2
    end
  end
end