class Api::V1::FriendlyGamesController < ApplicationController
  before_action :authenticate_user

  def create
    if current_user
      game = GamesFacade.repurpose(params)
      render json: FriendlyGameSerializer.new(game), status: :created
    else
      render json: {
        errors: ['please login first']
        }, status: 500
      end
    end

  def update
    if valid?(params)
      game = FriendlyGame.find_by(extension: params[:extension])
      game.current_fen = params[:fen]
      game.status = params[:status] if params[:status]
      game.save
      ActionCable.server.broadcast "friendly_games_channel_#{game.extension}", FriendlyGameSerializer.new(game)
      render json: { 'get it together chris': 'but actually'}, status: 200
    else
      render json: { errors: ['not yours to move'] }, status: 501
    end
  end

  protected

  def valid?(params)
    game = FriendlyGame.find_by(extension: params[:extension]) rescue nil
    id = current_user.id
    if game && id
      { 'w' => game.white_id, 'b' => game.black_id }[game.current_fen.split(' ')[1]] == id
    else
      false
    end
  end
end
