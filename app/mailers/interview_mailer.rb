class InterviewMailer < ApplicationMailer
  def new_interview_email
    @interview = params[:interview]

    mail(to: "#{@interview.candidate.email},#{@interview.recruiter.email}", subject: "Invitation:  #{@interview.candidate.fname} #{@interview.candidate.lname} and #{@interview.recruiter.name} @ #{Date.parse(@interview.interview_date.split(' ')[0])}, #{@interview.interview_date.split(' ')[1]} #{Time.zone.name}")
  end
end


