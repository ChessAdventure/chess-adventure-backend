class UserStatsSerializer
  include JSONAPI::Serializer
  set_type :user
  meta do |user|
    {
      last_game: {
        white: user.last_game.white.username,
        black: user.last_game.black.username,
        status: user.last_game.status,
        fen: user.last_game.current_fen
      }
    }
  end
end
