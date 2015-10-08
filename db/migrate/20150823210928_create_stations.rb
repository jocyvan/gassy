class CreateStations < ActiveRecord::Migration
  def change
    create_table :stations do |t|
      t.string :name
      t.string :city
      t.float :latitude
      t.float :longitude
      t.references :user, null: false

      t.timestamps null: false
    end

    add_index :stations, :user_id
  end
end
