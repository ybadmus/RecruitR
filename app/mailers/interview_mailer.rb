class InterviewMailer < ApplicationMailer
  def new_interview_email
    @interview = params[:interview]

    fullname = "#{@interview.candidate.fname} #{@interview.candidate.lname}"
    interview_date = Date.parse(@interview.interview_date.split[0]).to_s
    interview_time = @interview.interview_date.split[1]

    mail(to: "#{@interview.candidate.email},#{@interview.recruiter.email}",
         subject: "Invitation:  #{fullname} and #{@interview.recruiter.name} @ #{interview_date}, #{interview_time} #{Time.zone.name}")
  end
end
