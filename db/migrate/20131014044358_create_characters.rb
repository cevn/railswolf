class CreateCharacters < ActiveRecord::Migration
  def change
    create_table :characters do |t|
      t.float :lat
      t.float :long
      t.boolean :dead, default: false
      t.boolean :werewolf, default: false
      t.references :game_id

      t.timestamps
    end
  end
end
