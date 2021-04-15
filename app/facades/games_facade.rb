class GamesFacade
	class << self

    def repurpose(params)
      if params[:status]

      else
        fen = Fen.new().to_starting_position
        FriendlyGame.create(starting_fen: fen.fen)
      end
    end
  
    private
  end
end