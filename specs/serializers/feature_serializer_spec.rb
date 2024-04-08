require 'minitest/autorun'
require_relative '../spec_helper'
require_relative '../../src/models/feature.model'
require_relative '../../src/serializers/feature.serializer'
include Models

##
# Set of Feature Serializer class (which inherits from BaseSerializer class) tests
#
class FeatureSerializerSpec < Minitest::Test
  ##
  # Serializes a Feature model object, then compares it with an expected format
  def test_feature_serialization

    expected_format =
    {
      "id"=>nil,
      "type"=>"feature",
      "attributes"=>{
        "external_id"=>"123a",
        "magnitude"=>5.2,
        "place"=>"Atlantis",
        "time"=>1712416582640,
        "tsunami"=>0,
        "magType"=>"ml",
        "title"=>"M 2.3 - 14 km E of Coso Junction, CA",
        "coordinates"=>{
          "longitude"=>-117.7916667,
          "latitude"=>36.0268333
        }
      },
      "links"=>{
        "external_url"=> "http://localhost/earthquake"
      }
    }
    feature = Feature.new(
      external_id: "123a",
      magnitude: 5.2,
      place: "Atlantis",
      time: 1712416582640,
      url: "http://localhost/earthquake",
      tsunami: 0,
      magType: "ml",
      title: "M 2.3 - 14 km E of Coso Junction, CA",
      longitude: -117.7916667,
      latitude: 36.0268333
    )
    ser = FeatureSerializer.new(feature).serialize
    assert ser==expected_format
  end
end
