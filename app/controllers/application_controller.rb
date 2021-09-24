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
      flash[:error] = 'You must be logged in to access this section'
      redirect_to login_path
      false
    end
  end

  def logged_out?; end

  def client_options
    {
      client_id: '1026907825195-eqkadq4cbdrvemcbc73ocviesadebr7p.apps.googleusercontent.com',
      client_secret: '',
      authorization_uri: 'https://accounts.google.com/o/oauth2/auth',
      token_credential_uri: 'https://accounts.google.com/o/oauth2/token',
      scope: Google::Apis::CalendarV3::AUTH_CALENDAR, 
      #redirect_uri: 'https://secure-beyond-95793.herokuapp.com/callback'
      redirect_uri: 'http://localhost:3000/callback'
    }
  end
end
