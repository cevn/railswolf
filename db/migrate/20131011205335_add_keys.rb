class AddKeys < ActiveRecord::Migration
  def change
    add_foreign_key "characters", "games", name: "characters_game_id_fk"
    add_foreign_key "characters", "users", name: "characters_user_id_fk"
    add_foreign_key "games_users", "games", name: "games_users_game_id_fk"
    add_foreign_key "games_users", "users", name: "games_users_user_id_fk"
  end
end
