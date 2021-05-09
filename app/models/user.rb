class User < ApplicationRecord
  before_create :set_api

  has_secure_password
  validates :username, presence: true
  validates :username, uniqueness: { case_sensitive: false }
  validates :username, length: { minimum: 4 }
  validates :username, format: { without: /\s/}

  def self.from_token_request request
    username = request.params["auth"] && request.params["auth"]["username"]
    self.find_by username: username
  end

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

  def streak
    wins = FriendlyGame.wins(id)
    if wins.empty?
      'No wins yet'
    else
      start_of_streak = wins.max_by do |game|
        chain(game)
      end
      "#{chain(start_of_streak)} vs. #{start_of_streak.black.username}"
    end
  end

  private

  def chain(game, i = 0)
    begin
      if game.status == 'in_progress' || game.status == 'lost'
        i
      elsif game.status == 'drawn'
        chain(game.next_game, i)
      else
        chain(game.next_game, i + 1)
      end
    rescue
      i
    end
  end
end
