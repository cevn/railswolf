class AddLocationToKills < ActiveRecord::Migration
  def change
    add_column :kills, :latitude,  :float
    add_column :kills, :longitude, :float
  end
end
