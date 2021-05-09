class Api::V1::FriendlyGamesController < ApplicationController
  before_action :authenticate_user

  def create
    if current_user.is_fishing?
      
    else

    end
  end

  def wash
    fen = Fen.new(params[:fen])
    fen.to_starting_position
    render json: {data: "#{fen.fen}"}, status: :created
  end
end