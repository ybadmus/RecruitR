class Recruiter < ApplicationRecord
  validates :name, presence: true, length: { in: 3..100 }
  validates :email, presence: true, uniqueness: true, length: { in: 3..100 }
  validates :position_ids, presence: false

  has_many :recruiter_positions
  has_many :positions, through: :recruiter_positions
end
