class Api::V1::FriendlyGamesController < ApplicationController
  before_action :authenticate_user

  def create
    if current_user.is_fishing?
      
    else

    end
  end
end