class GamesFacade
	class << self

    def repurpose(params)
      if params[:extension]
        game = FriendlyGame.find_by(extension: params[:extension])
        if next_game = game.next_game
          next_game
        else
          if game.status == ('drawn' || 3)
            new_game = FriendlyGame.create(starting_fen: game.starting_fen, white_id: game.white_id, black_id: game.black_id)
          else
            new_game = new_game(game)
          end
          game.next_game_id = new_game.id
          game.save
          new_game
        end
      else
        fen = Fen.new().to_starting_position
        FriendlyGame.create(starting_fen: fen.fen)
      end
    end

    def add_player?(ext, id)
      game = FriendlyGame.find_by(extension: ext) rescue nil
      if game.nil? or game.black_id or game.white_id == id
        true
      else
        game.white_id ? game.black_id = id : game.white_id = id
        game.save
      end
    end

    private

    def new_game(game)
      if game.status == ('won' || 1)
        fen = Fen.new(game.current_fen).to_starting_position
        FriendlyGame.create(starting_fen: fen.fen, white_id: game.white_id, black_id: game.black_id)
      else
        fen = Fen.new(game.current_fen, true).to_starting_position
        FriendlyGame.create(starting_fen: fen.fen, white_id: game.black_id, black_id: game.white_id)
      end
    end
  end
end