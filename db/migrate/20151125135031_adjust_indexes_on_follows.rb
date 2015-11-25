class AdjustIndexesOnFollows < ActiveRecord::Migration
  def up
    execute 'SET FOREIGN_KEY_CHECKS=0;'
    remove_index :follows, :user_id
    remove_index :follows, :station_id
    execute 'SET FOREIGN_KEY_CHECKS=1;'

    add_index :follows, [:user_id, :station_id]
    add_index :follows, [:station_id, :user_id]
  end

  def down
    execute 'SET FOREIGN_KEY_CHECKS=0;'
    remove_index :follows, [:user_id, :station_id]
    remove_index :follows, [:station_id, :user_id]
    execute 'SET FOREIGN_KEY_CHECKS=1;'

    add_index :follows, :user_id
    add_index :follows, :station_id
  end
end
