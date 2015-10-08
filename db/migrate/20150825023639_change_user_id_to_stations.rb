class ChangeUserIdToStations < ActiveRecord::Migration
  def change
    change_column :stations, :user_id, :integer, null: true
  end
end
