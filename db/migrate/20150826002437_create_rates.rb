class CreateRates < ActiveRecord::Migration
  def change
    create_table :rates do |t|
      t.references :station, index: true, foreign_key: true
      t.references :user, index: true, foreign_key: true
      t.integer :status

      t.timestamps null: false
    end
  end
end
