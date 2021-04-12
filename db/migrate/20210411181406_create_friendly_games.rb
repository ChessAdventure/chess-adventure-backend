class CreateFriendlyGames < ActiveRecord::Migration[5.2]
  def change
    create_table :friendly_games do |t|
      t.references :white, index: true, foreign_key: {to_table: :users}
      t.references :black, index: true, foreign_key: {to_table: :users}
      t.integer :status
      t.string :starting_fen
      t.string :current_fen

      t.timestamps
    end
  end
end
