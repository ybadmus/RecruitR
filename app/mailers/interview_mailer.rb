class InterviewMailer < ApplicationMailer
  def new_interview_email
    @interview = params[:interview]

    mail(to: 'msmonroe147@gmail.com', subject: "You got a new order!")
  end
end
