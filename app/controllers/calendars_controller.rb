class CalendarsController < ApplicationController
  def google_signin
    client = Signet::OAuth2::Client.new(client_options)

    redirect_to client.authorization_uri.to_s
  end

  def callback
    client = Signet::OAuth2::Client.new(client_options)
    client.code = params[:code]
    token = client.fetch_access_token!
    session[:authorization] = token

    redirect_to root_path
  end
  
end