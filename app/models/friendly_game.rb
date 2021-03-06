class FriendlyGame < ApplicationRecord
  after_initialize :default_fen, :generate_extension, :default_status

  validates_presence_of :starting_fen
  validates_presence_of :current_fen, on: :update

  belongs_to :white, class_name: 'User', optional: true
  belongs_to :black, class_name: 'User', optional: true
  belongs_to :next_game, class_name: 'FriendlyGame', optional: true

  enum status: [:in_progress, :won, :lost, :drawn]

  scope :player, lambda{ |pid| 
    where("black_id = ? or white_id= ?", pid, pid)
  }

  scope :wins, lambda{ |pid| 
    where("white_id = ? and status = ?", pid, 1)
  }

  scope :loses, lambda{ |pid| 
    where("white_id = ? and status = ?", pid, 2)
  }

  def default_fen
    self.current_fen ||= self.starting_fen
  end

  def generate_extension
    self.extension ||= SecureRandom.base58(4)
  end

  def default_status
    self.status ||= 0
  end
end
