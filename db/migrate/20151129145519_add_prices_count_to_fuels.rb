class AddPricesCountToFuels < ActiveRecord::Migration
  def up
    add_column :fuels, :prices_count, :integer, default: 0

    Fuel.find_each do |fuel|
      Fuel.reset_counters(fuel.id, :prices)
    end
  end

  def down
    remove_column :fuels, :prices_count
  end
end
