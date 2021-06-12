module CandidatesHelper
  def candidate_skills candidate
    (candidate.position.skills.map {|skill| "#{skill.name}"}).join(', ') 
  end
end
