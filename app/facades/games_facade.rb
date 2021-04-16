class GamesFacade
	class << self

    def repurpose(params)
      if params[:status]

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
  end
end