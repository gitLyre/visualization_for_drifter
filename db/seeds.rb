# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
Location.delete_all
Location.create(:drifter_name => "Drifter #1",:latitude => "43.52408", :longitude => "-1.54721", :gps_time => DateTime.parse("04/12/2016 14:08:03 +0100"), :gps_speed => "1.9", :temp =>"12.2")
Location.create(:drifter_name => "Drifter #2",:latitude => "43.52412", :longitude => "-1.54712", :gps_time => DateTime.parse("04/12/2015 14:07:52 +0100"), :gps_speed => "12.1", :temp =>"13.1", :gps_tower =>"8", :battery_level =>"0", :sensor_name =>"TURBI", :sensor_data =>"60.5")
