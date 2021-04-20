class Api::V1::StatsController < ApplicationController
  def show
    begin
      user = User.find_by(username: params[:username])
      render json: UserStatsSerializer.new(user, {params: {game: user.last_game}}), status: 200
    rescue
      render json: { error: ['No user found'] }, status: 404
    end
  end
end