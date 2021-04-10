class Api::V1::UsersController < ApplicationController
  def index
    @users = User.all
    if @users
      render json: {
        users: @users
      }
    else
      render json: {
        status: 500,
        errors: ['no users found']
      }
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
        status: 500,
        errors: ['user not found']
      }
    end
  end

  def create
    begin
      @user = User.new(user_params)
      if @user.save
        login!  
        render json: {
          status: :created,
          user: @user
        }
      end
    rescue
      render json: {
        status: 500,
        errors: @user.errors.full_messages
      }
    end
  end

  private
  def user_params
    params.require(:user).permit(:username, :password, :password_confirmation)
  end
end