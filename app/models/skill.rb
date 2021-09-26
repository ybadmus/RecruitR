class Skill < ApplicationRecord
  validates :name, presence: true, length: { in: 3..50 }, uniqueness: true

  belongs_to :skillable, polymorphic: true
  has_many :positions
  has_many :recruiters
end
