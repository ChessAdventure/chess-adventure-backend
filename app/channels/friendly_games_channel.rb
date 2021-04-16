class FriendlyGamesChannel < ApplicationCable::Channel
  def subscribed
    stream_from "friendly_games_channel_#{params[:extension]}"
    GamesFacade.add_player?(params[:extension], params[:api_key])
    ActionCable.server.broadcast "friendly_games_channel_#{params[:extension]}", FriendlyGameSerializer.new(FriendlyGame.find_by(extension: params[:extension]))
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
