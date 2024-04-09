require 'minitest/autorun'
require 'minitest/hooks/test'
require_relative '../spec_helper'
require_relative '../../src/models/feature.model'
require_relative '../../src/models/comment.model'
require_relative '../../src/services/comment_service'
require_relative '../../src/errors/feature_does_not_exist_error'
include Models
include CustomErrors

##
# CommentService class with "create_comment_serialized" method tests
class CommentServiceCreateCommentSerializedSpec < Minitest::Test
  include Minitest::Hooks

  def before_all
    save_dummy_feature
    @comment_service = Services::CommentService.instance
  end

  def after_all
    DB[:comments].delete
    DB[:features].delete
  end

  def test_create_comment_serialized_with_correct_format
    expected_result = {
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

    message= "What a nice feature!"
    feature_id= 1

    comment_serialized = @comment_service.create_comment_serialized(message: message, feature_id: feature_id)
    comment_serialized["id"] = 1 # Overwrite id, sequence altered when running all tests

    assert_equal expected_result, comment_serialized
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
