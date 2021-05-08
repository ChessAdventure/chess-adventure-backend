class FriendlyGamesChannel < ApplicationCable::Channel
  def subscribed
    user = find_verified_user(params)
    GamesFacade.add_player?(params[:extension], user.id) if user
    stream_from "friendly_games_channel_#{params[:extension]}"
    ActionCable.server.broadcast "friendly_games_channel_#{params[:extension]}", FriendlyGameSerializer.new(FriendlyGame.find_by(extension: params[:extension]))
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  protected

  def find_verified_user(params)
    token = Knock::AuthToken.new token: params[:token]
    verified_user = User.find_by(id: token.payload['sub']) rescue nil
    verified_user
  end
end
