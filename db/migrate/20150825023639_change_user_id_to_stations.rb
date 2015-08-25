class ChangeUserIdToStations < ActiveRecord::Migration
  def up
    change_column :stations, :user_id, :integer, null: true

  end
  def down
    change_column :stations, :user_id, :integer, null: false    
  end
end
