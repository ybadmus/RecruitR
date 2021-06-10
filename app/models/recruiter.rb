class Recruiter < ApplicationRecord
  has_many :recruiter_positions
  has_many :positions, through: :recruiter_positions
end
