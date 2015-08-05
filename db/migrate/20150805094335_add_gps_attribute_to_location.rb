class AddGpsAttributeToLocation < ActiveRecord::Migration
  def change
    add_column :locations, :gps_tower, :text
    add_column :locations, :gps_time, :text
  end
end
