class UsersController < ApplicationController
  before_action :require_login, only: [:edit, :update]
  prepend_before_filter :set_user

  def new
    reset_session
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      sessions[:user_id] = @user.id 
      redirect_to root_path
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @user.update(user_params)
      redirect_to @user
    else
      render :edit
    end
  end

  private

    def user_params
      params.require(:user).permit(:username, :password)
    end

    def require_login
      if @user.id.eql? sessions[:user_id]
        true
      else
        flash[:error] = "You must be logged in to access this section"
        redirect_to new_user_path 
        false
      end
    end

    def set_user
      @user = User.find(params[:id])
    end
end