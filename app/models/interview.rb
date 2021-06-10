class Interview < ApplicationRecord
  belongs_to :candidate
  belongs_to :recruiter
  belongs_to :score, optional: true
end
