module Models
  class Comment < Sequel::Model
    plugin :json_serializer
    many_to_one :feature

    def validate
      super
      errors.add(:message, "can't be empty") if message.nil? || message.empty?
      errors.add(:feature_id, "can't be nil") if feature_id.nil?
    end
  end
end
