class ApplicationController < ActionController::Base
  helper_method :current_user, :logged_in?, :require_login, :logged_out?

  def current_user
    User.find_by(id: session[:id])
  end

  def logged_in?
    user = current_user
    !user.nil? && (user.id.eql? session[:id])
  end

  def require_login
    if logged_in? 
      true
    else
      flash[:error] = "You must be logged in to access this section"
      redirect_to login_path
      false
    end
  end

  def logged_out?
  end
end
