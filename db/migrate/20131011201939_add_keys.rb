class AddKeys < ActiveRecord::Migration
  def change
    add_foreign_key "characters", "games", name: "characters_game_id_fk"
    add_foreign_key "users",      "games", name: "users_game_id_fk"
  end
end
