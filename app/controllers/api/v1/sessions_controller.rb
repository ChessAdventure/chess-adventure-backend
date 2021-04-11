class Api::V1::SessionsController < ApplicationController
  def create
    @user = User.find_by(username: session_params[:username])
    if @user && @user.authenticate(session_params[:password])
      login!
      render json: UserSerializer.new(@user)
    else
      render json: { 
        # do we need logged_in: false here?
        errors: ['no such user, please try again']
      }, status: 401
    end
  end

  def is_logged_in?
    if logged_in? && current_user
      render json: {
        logged_in: true,
        user: current_user
      }
    else
      render json: {
        logged_in: false,
        # should this msg say 'not logged in' instead?
        message: 'no such user'
      }
    end
  end

  def destroy
    logout!
    render json: {
      logged_out: true
    }, status: 200
  end

  private
  def session_params
    params.require(:user).permit(:username, :password)
  end
end
