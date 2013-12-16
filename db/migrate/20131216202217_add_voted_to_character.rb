class AddVotedToCharacter < ActiveRecord::Migration
  def change
    add_column :characters, :voted, :boolean, default: false
  end
end
