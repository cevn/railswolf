class CreateCharacters < ActiveRecord::Migration
  def change
    create_table :characters do |t|
      t.float :latitude
      t.float :longitude
      t.boolean :dead, default: false
      t.boolean :werewolf, default: false
      t.belongs_to :user

      t.string :user_id

      t.timestamps
    end
  end
end
