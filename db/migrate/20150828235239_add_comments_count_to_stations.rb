class AddCommentsCountToStations < ActiveRecord::Migration
  def up
    add_column :stations, :comments_count, :integer, default: 0
    add_column :stations, :rates_count, :integer, default: 0

    Station.find_each do |station|
      Station.reset_counters(station.id, :comments)
      Station.reset_counters(station.id, :rates)
    end
  end

  def down
    remove_column :stations, :comments_count
    remove_column :stations, :rates_count
  end
end
