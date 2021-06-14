class Position < ApplicationRecord
  validates :name, presence: true, length: { in: 3..100 }, uniqueness: true
  validates :position_ids, presence: false

  has_many :position_skills
  has_many :skills, through: :position_skills
  
  has_many :candidates
  has_many :recruiter_positions
  has_many :recruiters, through: :recruiter_positions
end
