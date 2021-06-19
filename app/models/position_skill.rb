class PositionSkill < ApplicationRecord
  belongs_to :skill
  belongs_to :position

  validates_uniqueness_of :skill_id, scope: :position_id
end
