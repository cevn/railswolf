class AddVotesToCharacters < ActiveRecord::Migration
  def change
    add_column :characters, :votes, :int, default: 0
  end
end
