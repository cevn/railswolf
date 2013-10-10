class AddGamestuffToUsers < ActiveRecord::Migration
  def change
    add_column :users, :dead,     :boolean, default: false
    add_column :users, :werewolf, :boolean, default: false
  end
end
