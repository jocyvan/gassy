class AddFollowsCountToStations < ActiveRecord::Migration
  def up
    add_column :stations, :follows_count, :integer, default: 0

    Station.find_each do |station|
      Station.reset_counters(station.id, :follows)
    end
  end

  def down
    remove_column :stations, :follows_count
  end
end
