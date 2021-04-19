class GamesFacade
	class << self

    def repurpose(params)
      if params[:extension]
        game = FriendlyGame.find_by(extension: params[:extension])
        if next_game = game.next_game
          next_game
        else
          if game.status == 3
            new_game = FriendlyGame.create(starting_fen: game.starting_fen, white: game.white_id, black: game.black_id)
            game.next_game_id = new_game.id
            game.save
            new_game
          else
            new_game = new_game(game)
            game.next_game_id = new_game.id
            game.save
            new_game
          end
        end
      else
        fen = Fen.new().to_starting_position
        FriendlyGame.create(starting_fen: fen.fen)
      end
    end

    def add_player?(ext, api)
      # TODO fix this method to not clog the server if 1000 people subscribe
      # likely there should be a guard clause in the channel, not just here
      # maybe two clauses, one for ext, one for valid api_key
      game = FriendlyGame.find_by(extension: ext) rescue nil
      id = User.find_by(api_key: api).id rescue nil
      if game and (game.black_id || ((game.white_id != nil) && game.white_id == id))
        true
      else
        if game.white_id
          game.black_id = id
        else
          game.white_id = id
        end
        game.save
      end
    end

    private

    def new_game(game)
      if game.status == 1
        fen = Fen.new(game.current_fen).to_starting_position
        FriendlyGame.create(starting_fen: fen.fen, white_id: game.white_id, black_id: game.black_id)
      else
        fen = Fen.new(game.current_fen, true).to_starting_position
        FriendlyGame.create(starting_fen: fen.fen, white_id: game.black_id, black_id: game.white_id)
      end
    end
  end
end