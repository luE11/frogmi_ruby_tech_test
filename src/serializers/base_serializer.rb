##
# Base serializer class for Sequel models. Models should use :json_serializer plugin to use this class
class BaseSerializer
  attr_accessor :model
  def initialize(model)
    @model = model
  end

  ##
  # Converts model object to hash, with required format and the addition of hypermedia links
  def serialize()
    raise "Serialize method not implemented"
  end

end
