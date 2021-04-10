class Api::V1::UsersController < ApplicationController
  def index
    @users = User.all
    if @users != []
      render json: {
        users: @users
      }
    else
      render json: {
        errors: ['no users found']
      }, status: 500
    end
  end

  def show
    begin
      @user = User.find(params[:user_id])
      if @user
        render json: {
          user: @user
        }
      end
    rescue
      render json: {
        errors: ['user not found']
      }, status: 500
    end
  end

  def create
    @user = User.new(user_params)
    if @user.save
      login!  
      render json: {
        user: @user
      }, status: :created
    else
      render json: {
        errors: @user.errors.full_messages
      }, status: 500
    end
  end

  private
  def user_params
    params.require(:user).permit(:username, :password, :password_confirmation)
  end
end