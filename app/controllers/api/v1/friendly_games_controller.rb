class Api::V1::FriendlyGamesController < ApplicationController
  # def create
  #   binding.pry
  #   ActionCable.server.broadcast 'friendly_games_channel', {"hello": "hi bye"}
  # end
  def create
    if User.find_by(api_key: params[:api_key])
      game = GamesFacade.repurpose(params)
      render json: FriendlyGameSerializer.new(game), status: :created
    else
      render json: {
        errors: ['please login first']
      }, status: 500
    end
  end
end
