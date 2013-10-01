class CreateKills < ActiveRecord::Migration
  def change
    create_table :kills do |t|
      t.string :killer
      t.string :victim

      t.timestamps
    end
  end
end
