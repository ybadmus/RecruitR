class Recruiter < ApplicationRecord
  has_many :recruiter_skills
  has_many :skills, through: :recruiter_skills
end
