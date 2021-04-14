class FriendlyGamesChannel < ApplicationCable::Channel
  def subscribed
    stream_from "friendly_games_channel" # when ready, change this to:
    #  stream_from "friendly_games_channel_#{friendly_game.extension}"
    # this is where you should call params
    binding.pry
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  # def game_move(fen, key)
  #   some other method that you can call on the front end?
  # end
end
