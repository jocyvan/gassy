class AdjustIndexesOnRates < ActiveRecord::Migration
  def up
    execute 'SET FOREIGN_KEY_CHECKS=0;'
    remove_index :rates, :user_id
    remove_index :rates, :station_id
    execute 'SET FOREIGN_KEY_CHECKS=1;'

    add_index :rates, [:user_id, :station_id]
    add_index :rates, [:station_id, :user_id]
  end

  def down
    execute 'SET FOREIGN_KEY_CHECKS=0;'
    remove_index :rates, [:user_id, :station_id]
    remove_index :rates, [:station_id, :user_id]
    execute 'SET FOREIGN_KEY_CHECKS=1;'

    add_index :rates, :user_id
    add_index :rates, :station_id
  end
end
