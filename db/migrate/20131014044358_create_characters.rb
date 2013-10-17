class CreateCharacters < ActiveRecord::Migration
  def change
    create_table :characters do |t|
      t.float :lat
      t.float :long
      t.boolean :dead, default: false
      t.boolean :werewolf, default: false

      t.timestamps
    end
  end
end
