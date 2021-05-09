class AiGame < ApplicationRecord
  belongs_to :ai_quest
  after_initialize :default_fen, :default_status

  enum status: [:in_progress, :won, :lost, :drawn]

  def default_fen
    self.current_fen ||= self.starting_fen
  end

  def default_status
    self.status ||= 0
  end
end
