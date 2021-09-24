module GoogleCalendar
    class EventCreator < Base
        def perform
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

    redirect_to positions_path, notice: 'Interview invitation was successfully created.'
        end
    end
end