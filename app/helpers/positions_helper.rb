module PositionsHelper
  def applicants_no position
    position.candidates.size
  end

  def position_skills position
    (position.skills.map {|skill| "##{skill.name}"}).join(', ')
  end
end
