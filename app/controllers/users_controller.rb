class UsersController < ApplicationController
  before_action :require_login, only: [:edit, :update]

  def new
    reset_session
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      session[:id] = @user.id
      redirect_to root_path
    else
      render new_user_path @user
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])

    if @user.update(user_params)
      redirect_to @user
    else
      render edit_user_path @user
    end
  end

  private

    def user_params
      params.require(:user).permit(:username, :password)
    end
    
end