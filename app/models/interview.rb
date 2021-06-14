class Interview < ApplicationRecord
  validates :candidate_id, presence: true, length: { minimum: 1 }
  validates :recruiter_id, presence: true, length: { minimum: 1 }
  validates :interview_date, presence: true, length: { in: 1..20 }

  belongs_to :candidate
  belongs_to :recruiter
  belongs_to :score, optional: true
end
