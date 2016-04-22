class CreateLocations < ActiveRecord::Migration
  def change
    create_table :locations do |t|
      t.text :drifter_name
      t.float :latitude
      t.float :longitude
      t.datetime :gps_time
      t.text :time
      t.boolean :valid_input
      t.float :gps_speed
      t.text :sensor_name
      t.float :sensor_data
      t.float :temp
      t.float :battery_level
      t.float :gps_tower
      t.timestamps
    end
  end
end
