class Score < ApplicationRecord
  validates :experience, presence: true
  validates :dynamism, presence: true
  validates :interest, presence: true
  validates :enthusiasm, presence: true
  validates :technical_skill, presence: true
end
