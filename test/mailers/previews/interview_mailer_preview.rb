# Preview all emails at http://localhost:3000/rails/mailers/interview_mailer
class InterviewMailerPreview < ActionMailer::Preview
  def new_interview_email
    # Set up a temporary order for the preview
    interview = Interview.new(candidate_id: 6, recruiter_id: 7, interview_date: '10.02.2021 12 00')

    InterviewMailer.with(interview: interview).new_interview_email
  end
end
