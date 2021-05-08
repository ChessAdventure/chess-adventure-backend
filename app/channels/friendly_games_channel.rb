class FriendlyGamesChannel < ApplicationCable::Channel
  def subscribed
    a = connect(params)
    puts "a is: #{a}"
    GamesFacade.add_player?(params[:extension], current_user.id)
    stream_from "friendly_games_channel_#{params[:extension]}"
    ActionCable.server.broadcast "friendly_games_channel_#{params[:extension]}", FriendlyGameSerializer.new(FriendlyGame.find_by(extension: params[:extension]))
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  protected

  def connect(params)
    find_verified_user(params)
  end

  def find_verified_user(params)
    token = Knock::AuthToken.new token: params[:token]

    verified_user = User.find_by id: token.payload['sub']
    return verified_user if verified_user

    reject_unauthorized_connection
  end
end
