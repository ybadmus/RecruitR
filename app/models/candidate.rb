class Candidate < ApplicationRecord
  validates :fname, presence: true, length: { in: 1..20 }
  validates :lname, presence: true, length: { in: 1..20 }
  validates :email, presence: true, length: { in: 1..100 }
  validates :angelist, presence: true, length: { in: 1..30 }
  validates :linkedin, presence: true, length: { in: 1..30 }
  validates :position_id, presence: true, length: { minimum: 1 }

  belongs_to :position
end