class Position < ApplicationRecord
  has_many :position_skills
  has_many :skills, through: :position_skills
end
