class SessionsController < ApplicationController
  def new
  end
  
  def create
    user = User.find_by(id: params[:id])
            .try(:authenticate, params[:password])

    if user
      sessions[:user_id] = user.id 
    else
      flash.now[:error] = "Invalid login credentials"
      render user
  end

  def destroy
    reset_session
    render json: { status: 200, logged_out: true }
  end
end