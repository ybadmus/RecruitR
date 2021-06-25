class SessionsController < ApplicationController
  def new; end

  def create
    user = User.find_by(username: params[:username])
      .try(:authenticate, params[:password])

    if user
      session[:id] = user.id
      redirect_to redirect_path
    else
      flash.now[:error] = 'Invalid login credentials'
      render new_session_path
    end
  end

  def destroy
    reset_session
    redirect_to login_path
  end
end
