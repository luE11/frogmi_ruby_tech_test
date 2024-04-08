require_relative 'base_serializer'

##
# Feature model serializer class
class FeatureSerializer < BaseSerializer
  ##
  # Serialize a Feature model instance with the required format. Returns object attributes as a Hash
  def serialize
    jsn = model.to_json
    hash = JSON.parse(jsn)

    attributes = hash.except("id", "longitude", 'latitude', "url")
      .merge({
        "coordinates" => hash.slice("longitude", "latitude")
      })

    ser = {
      "id" => hash["id"],
      "type" => @model.class.name.split('::').last.downcase,
      "attributes" => attributes,
      "links" => {
        "external_url" => hash["url"]
      }
    }
    return ser
  end
end
