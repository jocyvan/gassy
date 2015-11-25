class AdjustIndexesOnPrices < ActiveRecord::Migration
  def up
    execute 'SET FOREIGN_KEY_CHECKS=0;'
    remove_index :prices, :fuel_id
    remove_index :prices, :station_id
    execute 'SET FOREIGN_KEY_CHECKS=1;'

    add_index :prices, [:fuel_id, :station_id]
    add_index :prices, [:station_id, :fuel_id]
  end

  def down
    execute 'SET FOREIGN_KEY_CHECKS=0;'
    remove_index :prices, [:fuel_id, :station_id]
    remove_index :prices, [:station_id, :fuel_id]
    execute 'SET FOREIGN_KEY_CHECKS=1;'

    add_index :prices, :fuel_id
    add_index :prices, :station_id
  end
end
