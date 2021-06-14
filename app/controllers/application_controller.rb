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

  def new_event interview
    client = Signet::OAuth2::Client.new(client_options)
    client.update!(session[:authorization])

    service = Google::Apis::CalendarV3::CalendarService.new
    service.authorization = client

    event = Google::Apis::CalendarV3::Event.new({
      start: Google::Apis::CalendarV3::EventDateTime.new(date_time: DateTime.parse(interview.interview_date)),
      end: Google::Apis::CalendarV3::EventDateTime.new(date_time: DateTime.parse(interview.interview_date) + 0.0417),
      summary: "#{interview.candidate.fname} #{interview.candidate.lname} and #{interview.recruiter.name}",
      attendees: [
        Google::Apis::CalendarV3::EventAttendee.new(
          email: interview.candidate.email
        ),
        Google::Apis::CalendarV3::EventAttendee.new(
          email: interview.recruiter.email
        )
      ],

      reminders: Google::Apis::CalendarV3::Event::Reminders.new(
        use_default: false,
        overrides: [
          Google::Apis::CalendarV3::EventReminder.new(
            reminder_method: 'email',
            minutes: 24 * 60
          ),
          Google::Apis::CalendarV3::EventReminder.new(
            reminder_method: 'popup',
            minutes: 10
          )
        ]
      )
    })

    begin
      service.insert_event('primary', event_object = event, send_notifications: true)
    rescue Google::Apis::AuthorizationError
      response = client.refresh!

      session[:authorization] = session[:authorization].merge(response)
      retry
    end

    redirect_to positions_path, notice: "Interview invitation was successfully created." 
  end

  def client_options
    {
      client_id: '844306511255-v6pgo5b6ksm7a2oavvjdeq0efr5acpgr.apps.googleusercontent.com',
      client_secret: 'LLzOh-U6MVrI69x4BtPYhM8V',
      authorization_uri: 'https://accounts.google.com/o/oauth2/auth',
      token_credential_uri: 'https://accounts.google.com/o/oauth2/token',
      scope: Google::Apis::CalendarV3::AUTH_CALENDAR,
      redirect_uri: 'http://localhost:3000/callback'
    }
  end
end
