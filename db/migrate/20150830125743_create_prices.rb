class CreatePrices < ActiveRecord::Migration
  def change
    create_table :prices do |t|
      t.references :fuel, index: true, foreign_key: true
      t.references :station, index: true, foreign_key: true
      t.float :value

      t.timestamps null: false
    end
  end
end
