class User < ApplicationRecord
  validates :username, presence: true, uniqueness: true, length: { in: 3..30 }, format: { with: /[a-zA-Z0-9]/ }
  has_secure_password
end
