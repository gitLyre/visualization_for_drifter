class AddBatteryLevelToLocation < ActiveRecord::Migration
  def change
    add_column :locations, :battery_level, :text
  end
end
