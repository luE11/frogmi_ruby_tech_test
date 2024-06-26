module Models
  ##
  # Feature Model class extended from Sequel::Model
  class Feature < Sequel::Model
    plugin :json_serializer
    def validate
      super
      errors.add(:title, "can't be empty") if title.nil? || title.empty?
      errors.add(:url, "can't be empty") if url.nil? || url.empty?
      errors.add(:place, "can't be empty") if place.nil? || place.empty?
      errors.add(:mag_type, "can't be empty") if mag_type.nil? || mag_type.empty?
      errors.add(:latitude, "can't be empty") if latitude.nil?
      errors.add(:longitude, "can't be empty") if longitude.nil?
      errors.add(:magnitude, "must be between -1.0 and 10.0") if magnitude && (magnitude<-1 || magnitude>10)
      errors.add(:latitude, "must be between -90.0 and 90.0") if latitude && (latitude<-90 || latitude>90)
      errors.add(:longitude, "must be between -180.0 and 180.0") if longitude && (longitude<-180 || longitude>180)
    end
  end
end
