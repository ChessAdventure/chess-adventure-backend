class User < ApplicationRecord
  before_create :set_api
  has_secure_password
  validates :username, presence: true
  validates :username, uniqueness: { case_sensitive: false }
  validates :username, length: { minimum: 4 }

  def set_api
    self.api_key = SecureRandom.uuid
  end
end