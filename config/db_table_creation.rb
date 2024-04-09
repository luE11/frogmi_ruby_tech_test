puts "Creating tables"

DB.create_table? :features do
  primary_key(:id)
  String :external_id, unique: true
  Float :magnitude
  String :place, null: false
  Time :time
  String :url, null: false
  Integer :tsunami
  String :mag_type, null: false
  String :title, null: false
  Float :longitude, null: false
  Float :latitude, null: false
  constraint(:mag_range){magnitude>=-1.0 && magnitude<=10.0}
  constraint(:mag_latitude){magnitude>=-90.0 && magnitude<=90.0}
  constraint(:mag_longitude){magnitude>=-180.0 && magnitude<=180.0}
end

DB.create_table? :comments do
  primary_key :id
  String :message, null: false
  foreign_key :feature_id, :features
end
