class Interview < ApplicationRecord
  belongs_to :candidate
  belongs_to :recruiter
  has_one :score
end
