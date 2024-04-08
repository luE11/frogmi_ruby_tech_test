##
# Base serializer class for Sequel models. Models should use :json_serializer plugin to use this class
class BaseSerializer
  attr_accessor :model
  def initialize(model)
    @model = model
  end

  def links
    {}
  end

  ##
  # Converts model object to hash, with required format and the addition of hypermedia links
  def serialize()
    jsn = model.to_json
    hash = JSON.parse(jsn)

    ser = {
      "id" => hash["id"],
      "type" => @model.class.name.split('::').last.downcase,
      "attributes" => hash.except("id"),
      "links" => links
    }
    return ser
  end

end
