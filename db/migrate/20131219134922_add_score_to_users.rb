class AddScoreToUsers < ActiveRecord::Migration
  def change
    add_column :users, :score, :integer, default: 0
    add_column :users, :max_score, :integer, default: 0
  end
end
