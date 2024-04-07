puts "Creating tables"

DB.create_table? :features do
  primary_key(:id)
  String :external_id, unique: true
  Float :mag
  String :place, null: false
  Time :time
  String :url, null: false
  Integer :tsunami
  String :magType, null: false
  String :title, null: false
  Float :longitude, null: false
  Float :latitude, null: false
  constraint(:mag_range){mag>=-1.0 && mag<=10.0}
  constraint(:mag_latitude){mag>=-90.0 && mag<=90.0}
  constraint(:mag_longitude){mag>=-180.0 && mag<=180.0}
end

DB.create_table? :comments do
  primary_key :id
  String :comment, null: false
  foreign_key :feature_id, :features
end
