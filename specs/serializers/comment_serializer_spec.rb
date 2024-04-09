require 'minitest/autorun'
require 'minitest/hooks/test'
require_relative '../spec_helper'
require_relative '../../src/models/feature.model'
require_relative '../../src/models/comment.model'
require_relative '../../src/serializers/comment.serializer'
include Models

##
# Set of Comment Serializer class (which inherits from BaseSerializer class) tests
#
class CommentSerializerSpec < Minitest::Test
  include Minitest::Hooks

  def before_all
    save_dummy_feature
  end

  def after_all
    DB[:comments].delete
    DB[:features].delete
  end

  ##
  # Serializes a Comment model object, then compares it with an expected format
  def test_comment_serialization

    expected_format =
    {
      "id"=>1,
      "type"=>"comment",
      "attributes"=>{
        "message"=>"What a nice feature!",
        "feature"=>{
          "id"=>1,
          "type"=>"feature",
          "attributes"=>{
            "external_id"=>"123a",
            "magnitude"=>5.2,
            "place"=>"Atlantis",
            "time"=>"56234-04-28 03:57:20 -0500",
            "tsunami"=>0,
            "mag_type"=>"md",
            "title"=>"M 2.3 - 14 km E of Coso Junction, CA123",
            "coordinates"=>{
              "longitude"=>-117.7916667,
              "latitude"=>36.0268333
            }
          },
          "links"=>{
            "external_url"=>"http://localhost/earthquake/123a"
          }
        }
      }
    }

    comment = Comment.new(message: "What a nice feature!", feature_id: 1).tap { |o| o.id = 1 }
    comment.save

    ser = CommentSerializer.new(comment).serialize

    assert ser==expected_format
  end

  def save_dummy_feature
    feature = Feature.new(
      external_id: "123a",
      magnitude: 5.2,
      place: "Atlantis",
      time: 1712416582640,
      url: "http://localhost/earthquake/123a",
      tsunami: 0,
      mag_type: "md",
      title: "M 2.3 - 14 km E of Coso Junction, CA123",
      longitude: -117.7916667,
      latitude: 36.0268333
    ).tap { |o| o.id = 1 }
    feature.save
  end
end
