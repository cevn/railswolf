class CreateCharacters < ActiveRecord::Migration
  def change
    create_table :characters do |t|
      t.integer :game_id
      t.integer :user_id
      t.integer :char_id
      t.string  :name
      t.boolean :dead
      t.boolean :werewolf

      t.timestamps
    end
  end
end
