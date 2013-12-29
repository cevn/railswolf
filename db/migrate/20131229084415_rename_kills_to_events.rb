class RenameKillsToEvents < ActiveRecord::Migration
  def change
    rename_table :kills, :events
    add_column :events, :event_type, :string
  end
end
