class AddNextGameToFriendlyGames < ActiveRecord::Migration[5.2]
  def change
    add_reference :friendly_games, :next_game, foreign_key: {to_table: :friendly_games}
  end
end
