class FriendlyGamesChannel < ApplicationCable::Channel
  def subscribed
    stream_from "friendly_games_channel_#{params[:extension]}"
    GamesFacade.add_player?(params[:extension], params[:api_key])
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
