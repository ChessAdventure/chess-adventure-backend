class CreateAiGames < ActiveRecord::Migration[5.2]
  def change
    create_table :ai_games do |t|
      t.references :ai_quest, foreign_key: true
      t.integer :status
      t.string :starting_fen
      t.string :current_fen

      t.timestamps
    end
  end
end
