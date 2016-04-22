class Location < ActiveRecord::Base
	attr_accessible  :drifter_name, :latitude, :longitude, :gps_time, :time, :gps_speed, :sensor_name, :sensor_data, :battery_level, :gps_tower, :temp

	def self.to_csv(options = {})
  		CSV.generate(options) do |csv|
    		#csv << column_names
				csv << ["id", "drifter_name", "latitude", "longitude", "gps_time", "time", "gps_speed", "sensor_name", "sensor_data","battery_level","gps_tower", "temp"]
    		all.each do |loc|
      			#csv << loc.attributes.values_at(*column_names)
						if loc.gps_time.nil?
							loc.gps_time = loc.created_at
						end
						if loc.time.nil?
							time_csv = nil
						else
							time_csv = loc.time
						end
						csv << [loc.id, loc.drifter_name, loc.latitude, loc.longitude, loc.gps_time.strftime('%d/%m/%Y %H:%M:%S %z'), time_csv, loc.gps_speed, loc.sensor_name, loc.sensor_data, loc.battery_level, loc.gps_tower, loc.temp]
    		end
  		end
	end

  def self.import(file)
    spreadsheet = open_spreadsheet(file)
    header = spreadsheet.row(1)
    (2..spreadsheet.last_row).each do |i|
      row = Hash[[header, spreadsheet.row(i)].transpose]
      location = find_by_id(row["id"]) || new
			testvar = row[:gps_time]
			#location.attributes = row.to_hash.slice(*accessible_attributes)
			location.drifter_name = row["drifter_name"]
			location.latitude = row["latitude"]
			location.longitude = row["longitude"]
			location.gps_time = DateTime.parse(row["gps_time"])
			if !row["time"].nil?
				location.time = row["time"]
			end
			location.gps_speed = row["gps_speed"]
			location.sensor_name = row["sensor_name"]
			location.sensor_data = row["sensor_data"]
			location.battery_level = row["battery_level"]
			location.gps_tower = row["gps_tower"]
			location.temp = row["temp"]
      location.save!
    end
  end

  def self.open_spreadsheet(file)
    case File.extname(file.original_filename)
    when ".csv" then Roo::Csv.new(file.path, nil, :ignore)
    when ".xls" then Roo::Excel.new(file.path, nil, :ignore)
    when ".xlsx" then Roo::Excelx.new(file.path, nil, :ignore)
    else raise "Unknown file type: #{file.original_filename}"
    end
  end

end
