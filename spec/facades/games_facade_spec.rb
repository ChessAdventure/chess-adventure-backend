require 'rails_helper'

describe GamesFacade do
	describe "happy path" do
    describe 'repurpose' do
      it 'should make a default game if not passed an extension' do
        game = GamesFacade.repurpose({})

        expect(game.current_fen).to eq('rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR w KQkq - 0 1')
        expect(game.starting_fen).to eq('rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR w KQkq - 0 1')
        expect(game.black).to be nil
        expect(game.white).to be nil
        expect(game.next_game).to be nil
      end

      it 'should make a new game from the same position in a tie' do
        user = User.create(username: 'John Doe', password: 'Password')
        user2 = User.create(username: 'Jane Doe', password: 'Password')
        game = FriendlyGame.create(starting_fen: 'rnbqkbnr/pppppppp/8/8/8/8/PPPPPP2/RNBQKBNR w KQkq - 0 1', current_fen: '1R6/p2r4/2ppkp2/6p1/2PKP2p/P4P2/6PP/8 b - - 0 0', white_id: user.id, black_id: user2.id, status: 3)

        params = {
          extension: game.extension
        }

        new_game = GamesFacade.repurpose(params)
        expect(new_game.current_fen).to eq(game.starting_fen)
        expect(new_game.white_id).to eq(game.white_id)
        expect(new_game.black_id).to eq(game.black_id)
      end

      it 'should properly keep white as white if it wins' do
        user = User.create(username: 'John Doe', password: 'Password')
        user2 = User.create(username: 'Jane Doe', password: 'Password')
        game = FriendlyGame.create(starting_fen: 'rnbqkbnr/pppppppp/8/8/8/8/PPPPPP2/RNBQKBNR w KQkq - 0 1', current_fen: '1R6/p2r4/2ppkp2/6p1/2PKP2p/P4P2/6PP/8 b - - 0 0', white_id: user.id, black_id: user2.id, status: 1)

        params = {
          extension: game.extension
        }

        new_game = GamesFacade.repurpose(params)
        expect(new_game.current_fen).to eq('rnbqkbnr/pppppppp/8/8/8/8/PPPPPP2/R3K3 w Qkq - 0 1')
        expect(new_game.white_id).to eq(game.white_id)
        expect(new_game.black_id).to eq(game.black_id)
      end

      it 'should properly keep make black white if it wins' do
        user = User.create(username: 'John Doe', password: 'Password')
        user2 = User.create(username: 'Jane Doe', password: 'Password')
        game = FriendlyGame.create(starting_fen: 'rnbqkbnr/pppppppp/8/8/8/8/PPPPPP2/RNBQKBNR w KQkq - 0 1', current_fen: '1R6/3r4/2ppkp2/6p1/2PKP2p/P4P2/6PP/8 b - - 0 0', white_id: user.id, black_id: user2.id, status: 2)

        params = {
          extension: game.extension
        }

        new_game = GamesFacade.repurpose(params)
        expect(new_game.current_fen).to eq('rnbqkbnr/pppppppp/8/8/8/8/PPPPP3/R3K3 w Qkq - 0 1')
        expect(new_game.white_id).to eq(game.black_id)
        expect(new_game.black_id).to eq(game.white_id)
      end

      it 'should not make a new game if one already exists' do
        user = User.create(username: 'John Doe', password: 'Password')
        user2 = User.create(username: 'Jane Doe', password: 'Password')
        game = FriendlyGame.create(starting_fen: 'rnbqkbnr/pppppppp/8/8/8/8/PPPPPP2/RNBQKBNR w KQkq - 0 1', current_fen: '1R6/3r4/2ppkp2/6p1/2PKP2p/P4P2/6PP/8 b - - 0 0', white_id: user.id, black_id: user2.id, status: 2)

        game2 = FriendlyGame.create(starting_fen: 'rnbqkbnr/pppppppp/8/8/8/8/PPPPPP2/RNBQKBNR w KQkq - 0 1')

        game.update(next_game_id: game2.id)

        params = {
          extension: game.extension
        }

        new_game = GamesFacade.repurpose(params)
        expect(new_game).to eq(game2)
      end
    end

    describe 'add_player?' do
      it 'should add the first player as white' do
        user = User.create(username: 'John Doe', password: 'Password')
        user2 = User.create(username: 'Jane Doe', password: 'Password')
        game = FriendlyGame.create(starting_fen: 'rnbqkbnr/pppppppp/8/8/8/8/PPPPPP2/RNBQKBNR w KQkq - 0 1')

        GamesFacade.add_player?(game.extension, user.api_key)
        game = FriendlyGame.find(game.id)

        expect(game.white_id).to eq(user.id)
        expect(game.black_id).to be nil

        
        GamesFacade.add_player?(game.extension, user.api_key)
        game = FriendlyGame.find(game.id)

        expect(game.white_id).to eq(user.id)
        expect(game.black_id).to be nil

        GamesFacade.add_player?(game.extension, user2.api_key)
        game = FriendlyGame.find(game.id)

        expect(game.white_id).to eq(user.id)
        expect(game.black_id).to eq(user2.id)
      end
    end
  end
end