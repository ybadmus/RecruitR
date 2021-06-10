class Skill < ApplicationRecord
  has_many :position_skills
  has_many :positions, through: :position_skills
end
