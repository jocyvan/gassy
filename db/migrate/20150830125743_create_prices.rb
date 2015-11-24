class CreatePrices < ActiveRecord::Migration
  def change
    create_table :prices do |t|
      t.references :fuel, foreign_key: true
      t.references :station, foreign_key: true
      t.float :value

      t.timestamps null: false
    end
    add_index :prices, [:fuel_id, :station_id]
    add_index :prices, [:station_id, :fuel_id]
  end
end
