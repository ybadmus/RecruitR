class Skill < ApplicationRecord
  has_many :position_skills
  has_many :positions, through: :position_skills

  has_many :recruiter_skills
  has_many :recruiters, through: :recruiter_skills
end
