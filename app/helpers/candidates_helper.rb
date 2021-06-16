module CandidatesHelper
  def candidate_skills(candidate)
    (candidate.position.skills.map { |skill| skill.name.to_s }).join(', ')
  end

  def schedule_interview_card(candidate)
    if candidate.matched
      raw('<strong>This candidate has already been matched</strong>')
    else

      render 'interviews/form', interview: @interview
    end
  end
end
