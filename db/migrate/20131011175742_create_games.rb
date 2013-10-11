class CreateGames < ActiveRecord::Migration
  def change
    create_table :games do |t|
      t.string  :events
      t.boolean :day
      t.boolean :play

      t.timestamps
    end
  end
end
