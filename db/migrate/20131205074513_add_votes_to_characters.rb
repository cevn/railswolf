class AddVotesToCharacters < ActiveRecord::Migration
  def change
    add_column :characters, :were_votes, :int, default: 0
    add_column :characters, :town_votes, :int, default: 0
  end
end
