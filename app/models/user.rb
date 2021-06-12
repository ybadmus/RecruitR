class User < ApplicationRecord
  validates :username, presence: true, uniqueness: true, length: { in: 3..16 }, format: { with: /[a-zA-Z0-9]/ }
  validates : remember_token, presence: true
  
  has_secure_password
end
