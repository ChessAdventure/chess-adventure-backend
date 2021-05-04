class FriendlyGamesChannel < ApplicationCable::Channel
  def subscribed
    GamesFacade.add_player?(params[:extension], current_user.id) if :authenticate_user
    stream_from "friendly_games_channel_#{params[:extension]}"
    ActionCable.server.broadcast "friendly_games_channel_#{params[:extension]}", FriendlyGameSerializer.new(FriendlyGame.find_by(extension: params[:extension]))
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
