class User < ApplicationRecord
  has_secure_password
  validates :username, presence: true
  validates :username, uniqueness: { case_sensitive: false }
  validates :username, length: { minimum: 4 }
  validates :email, presence: true
  validates :email, uniqueness: { case_sensitive: false }
end
