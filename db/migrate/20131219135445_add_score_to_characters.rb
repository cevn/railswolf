class AddScoreToCharacters < ActiveRecord::Migration
  def change
    add_column :characters, :score, :integer, default: 0 
    add_column :characters, :max_score, :integer, default: 0
  end
end
