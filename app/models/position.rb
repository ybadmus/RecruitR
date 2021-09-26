class Position < ApplicationRecord
  validates :name, presence: true, length: { in: 3..100 }, uniqueness: true
  validates :position_ids, presence: false

  has_many :skills, as: :skillable
  has_many :candidates
end
