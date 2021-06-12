class ApplicationController < ActionController::Base
  helper_method :current_user, :logged_in?, :require_login, :logged_out?

  def current_user
    User.find_by(id: session[:id])
  end

  def logged_in?
    !current_user.nil?
  end

  def require_login
    puts logged_in? && (current_user.id.eql? session[:id])
    
    if logged_in? && (current_user.id.eql? session[:id])
      true
    else
      flash[:error] = "You must be logged in to access this section"
      redirect_to login_path
      false
    end
  end
end
