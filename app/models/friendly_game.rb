class FriendlyGame < ApplicationRecord
  after_initialize :default_fen

  validates_presence_of :status
  validates_presence_of :starting_fen
  validates_presence_of :current_fen, on: :update

  belongs_to :white
  belongs_to :black

  enum status: [:in_progress, :won, :lost, :drawn]

  def default_fen
    self.current_fen ||= self.starting_fen
  end
end
