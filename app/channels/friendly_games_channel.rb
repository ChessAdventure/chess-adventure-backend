class FriendlyGamesChannel < ApplicationCable::Channel
  def subscribed
    stream_from "friendly_games_channel"
    FriendlyGame.create!(starting_fen: 'a')
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def game_move(fen, key)

  end
end
