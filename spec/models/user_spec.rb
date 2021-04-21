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
      user = User.create!(username: 'JohnDoe', password: '123456')
      user2 = User.create!(username: 'JaneDoe', password: '123')
      user3 = User.create!(username: 'V---', password: '123')
      game = FriendlyGame.create!(starting_fen: 'rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR w KQkq - 0 1', white_id: user.id, black_id: user2.id, status: 1)
      game2 = FriendlyGame.create!(starting_fen: 'rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR w KQkq - 0 1', white_id: user.id, black_id: user2.id, status: 1)
      game3 = FriendlyGame.create!(starting_fen: 'rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR w KQkq - 0 1', white_id: user.id, black_id: user2.id, status: 2)
      game4 = FriendlyGame.create!(starting_fen: 'rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR w KQkq - 0 1', white_id: user2.id, black_id: user.id, status: 0)
      game5 = FriendlyGame.create!(starting_fen: 'rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR w KQkq - 0 1', white_id: user3.id, black_id: user.id, status: 1)
      game6 = FriendlyGame.create!(starting_fen: 'rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR w KQkq - 0 1', white_id: user3.id, black_id: user.id, status: 1)
      game7 = FriendlyGame.create!(starting_fen: 'rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR w KQkq - 0 1', white_id: user3.id, black_id: user.id, status: 1)
      game8 = FriendlyGame.create!(starting_fen: 'rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR w KQkq - 0 1', white_id: user3.id, black_id: user.id, status: 2)
      game9 = FriendlyGame.create!(starting_fen: 'rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR w KQkq - 0 1', white_id: user.id, black_id: user3.id, status: 3)
      game10 = FriendlyGame.create!(starting_fen: 'rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR w KQkq - 0 1', white_id: user.id, black_id: user3.id, status: 1)
      game11 = FriendlyGame.create!(starting_fen: 'rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR w KQkq - 0 1', white_id: user.id, black_id: user3.id, status: 3)



      game.update(next_game_id: game2.id)
      game2.update(next_game_id: game3.id)
      game3.update(next_game_id: game4.id)
      game5.update(next_game_id: game6.id)
      game6.update(next_game_id: game11.id)
      game7.update(next_game_id: game8.id)
      game8.update(next_game_id: game9.id)
      game9.update(next_game_id: game10.id)
      game11.update(next_game_id: game7.id)

      expect(user.streak).to eq("2 vs. #{user2.username}")
      expect(user2.streak).to eq("No wins yet")
      expect(user3.streak).to eq("3 vs. #{user.username}")
    end
  end
end