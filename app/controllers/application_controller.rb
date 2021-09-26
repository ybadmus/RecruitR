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
      client_id: Rails.application.credentials[Rails.env.to_sym][:google_calendar][:client_id],
      client_secret: Rails.application.credentials[Rails.env.to_sym][:google_calendar][:client_secret],
      authorization_uri: Rails.application.credentials[Rails.env.to_sym][:google_calendar][:authorization_uri],
      token_credential_uri: Rails.application.credentials[Rails.env.to_sym][:google_calendar][:token_credential_uri],
      scope: Google::Apis::CalendarV3::AUTH_CALENDAR,
      redirect_uri: Rails.application.credentials[Rails.env.to_sym][:google_calendar][:redirect_uri]
    }
  end
  
end
