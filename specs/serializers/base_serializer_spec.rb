require 'minitest/autorun'
require_relative '../spec_helper'
require_relative '../../src/models/feature.model'
require_relative '../../src/serializers/base_serializer'
include Models

##
# Set of Feature model validation tests
#
class FeatureModelSpec < Minitest::Test
  ##
  # Creates a Feature object with valid attribute values.
  # Then asserts that the Feature instance is valid
  def test_feature_serialization

    expected_format = {
      "id"=>nil,
      "type"=>"feature",
      "attributes"=>{
        "external_id"=>"123a",
        "mag"=>5.2,
        "place"=>"Atlantis",
        "time"=>1712416582640,
        "url"=>"http://localhost/earthquake",
        "tsunami"=>0, "magType"=>"ml",
        "title"=>"M 2.3 - 14 km E of Coso Junction, CA",
        "longitude"=>-117.7916667,
        "latitude"=>36.0268333
      },
      "links"=>{
      }
    }
    feature = Feature.new(
      external_id: "123a",
      mag: 5.2,
      place: "Atlantis",
      time: 1712416582640,
      url: "http://localhost/earthquake",
      tsunami: 0,
      magType: "ml",
      title: "M 2.3 - 14 km E of Coso Junction, CA",
      longitude: -117.7916667,
      latitude: 36.0268333
    )
    ser = BaseSerializer.new(feature).serialize
    assert ser==expected_format
  end
end
