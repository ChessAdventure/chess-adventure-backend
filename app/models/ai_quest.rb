class AiQuest < ApplicationRecord
  belongs_to :black_id

  after_initialize :default_status

  enum status: [:in_progress, :ended]

  def default_status
    self.status ||= 0
  end
end
