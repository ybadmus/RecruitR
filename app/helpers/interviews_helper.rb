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
     
      render 'score', score: @score
    end
  end
end