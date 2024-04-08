require_relative 'base_serializer'
require_relative '../models/comment.model'
require_relative 'feature.serializer'
include Models

##
# Comment model serializer class
class CommentSerializer < BaseSerializer
  ##
  # Serialize a Comment model instance. Returns object attributes as a Hash
  def serialize
    jsn = model.to_json
    hash = JSON.parse(jsn)

    serialized_feature = FeatureSerializer.new(model.feature).serialize

    attributes = hash.except("id")
      .merge({
        "feature" => serialized_feature
      })

    ser = {
      "id" => hash["id"],
      "type" => Comment.name.split('::').last.downcase,
      "attributes" => attributes
    }
    return ser
  end
end
