class Skill < ApplicationRecord
  validates :name, presence: true, length: { in: 3..100 }, uniqueness: true

  has_many :position_skills
  has_many :positions, through: :position_skills
end
