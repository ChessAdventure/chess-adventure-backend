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
        game = FriendlyGame.create(starting_fen: 'rnbqkbnr/pppppppp/8/8/8/8/PPPP2PP/RNBQKBNR w KQkq - 0 1', current_fen: '1R6/p2r4/2ppkp2/6p1/2PKP2p/P4P2/6PP/8 b - - 0 0', white_id: user.id, black_id: user2.id, status: 3)

        params = {}
      end
    end
  end
end