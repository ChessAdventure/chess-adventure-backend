class User < ApplicationRecord
  before_create :set_api

  has_secure_password
  validates :username, presence: true
  validates :username, uniqueness: { case_sensitive: false }
  validates :username, length: { minimum: 4 }
  validates :username, format: { without: /\s/}

  def set_api
    self.api_key = SecureRandom.uuid
  end

  def last_game
    friendly_games.where('status > ?', 0).order(updated_at: :desc).first
  end

  def friendly_games
    FriendlyGame.player(id)
  end

  def friendly_ratio
    "#{FriendlyGame.wins(id).count}-#{FriendlyGame.loses(id).count}"
  end
end
