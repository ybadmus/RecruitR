module InterviewsHelper
  def interview_closed? interview
    interview.closed ? "Closed" : "Opened"
  end

  def calculate_score interview
    interview.score.nil? ? "N/a" : "#{interview.score.experience + interview.score.dynamism + interview.score.interest + interview.score.enthusiasm + interview.score.technical_skill}%"
  end

  def interview_score interview
    if(!interview.score.nil?)
      raw("<p>
        <strong>Score:</strong>
        #{interview.score.experience + interview.score.dynamism + interview.score.interest + interview.score.enthusiasm + interview.score.technical_skill}%
      </p>")
    end
  end

  def display_scorecard interview
    if interview.closed
      raw("<h4>The interview have been closed</h4>")
    else 
      raw("<h4>Applicant scorecard (set range between 1 - 10 points)</h4>
      #{render 'score', score: @score}")
    end
  end
end