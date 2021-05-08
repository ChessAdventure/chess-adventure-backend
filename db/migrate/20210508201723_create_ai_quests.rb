class CreateAiQuests < ActiveRecord::Migration[5.2]
  def change
    create_table :ai_quests do |t|
      t.references :black, index: true, foreign_key: {to_table: :users}
      t.integer :status

      t.timestamps
    end
  end
end
