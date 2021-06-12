module CandidatesHelper
  def candidate_skills candidate
    (candidate.position.skills.map {|skill| "#{skill.name}"}).join(', ') 
  end

  def schedule_interview_card candidate
    if candidate.matched
      raw("<strong>This candidate has already been matched</strong>")
    else 
      raw("<strong>Suggested recruiters with the matching skills:</strong>
      #{render 'interviews/form', score: @score}")
    end
  end
end