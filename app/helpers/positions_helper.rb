module PositionsHelper
  def no_applicants position
    position.candidates.size
  end
end
