class PositionSkill < ApplicationRecord
  validates :skillId, presence: false
  validates :positionId, presence: false

  belongs_to :skill
  belongs_to :position
end
