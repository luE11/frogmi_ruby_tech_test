module Models
  class Feature < Sequel::Model
    def validate
      super
      errors.add(:title, "can't be empty") if title.empty?
      errors.add(:url, "can't be empty") if url.empty?
      errors.add(:place, "can't be empty") if place.empty?
      errors.add(:magType, "can't be empty") if magType.empty?
      errors.add(:mag, "must be between -1.0 and 10.0") if mag<-1 || mag>10
      errors.add(:latitude, "must be between -90.0 and 90.0") if latitude<-90 || latitude>90
      errors.add(:longitude, "must be between -180.0 and 180.0") if longitude<-180 || longitude>180
    end
  end
end
