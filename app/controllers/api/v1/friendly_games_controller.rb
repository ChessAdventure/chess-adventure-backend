class Api::V1::FriendlyGamesController < ApplicationController
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
