class AddExtensionToFriendlyGames < ActiveRecord::Migration[5.2]
  def change
    add_column :friendly_games, :extension, :string
  end
end
