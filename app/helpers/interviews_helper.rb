module InterviewsHelper
  def interview_closed?(interview)
    interview.closed ? 'Closed' : 'Opened'
  end

  def calculate_score(interview)
    return 'N/a' if interview.score.nil?

    "#{interview.score.experience + interview.score.dynamism + interview.score.interest + interview.score.enthusiasm + interview.score.technical_skill}%"
  end

  def interview_score(interview)
    return if interview.score.nil?

    raw("<p>
            <strong>Score:</strong>
            #{interview.score.experience + interview.score.dynamism + interview.score.interest + interview.score.enthusiasm + interview.score.technical_skill}%
          </p>")
  end

  def display_scorecard(interview)
    if interview.closed
      raw("<h4>The interview have been closed</h4><h5>#{interview_score interview}</h5>")
    else
      raw("<h6><b>Applicant scorecard (set range between 1 - 10 points)</b></h6>
      #{render 'score', score: @score}")
    end
  end
end
