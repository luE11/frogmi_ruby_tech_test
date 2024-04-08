require 'minitest/autorun'
require_relative '../spec_helper'
require_relative '../../src/models/feature.model'
require_relative '../../src/serializers/feature.serializer'
require_relative '../../src/serializers/serializer_set'
include Models

##
# SerializerSet class tests
#
class SerializerSetSpec < Minitest::Test
  ##
  # Executes the SerializerSet "format" method with an array of FeatureSerializer instances as parameter.
  # Then checks if the output matches the required format
  def test_set_serialization

    expected_format =
    {
      "data"=>[
        {
          "id"=>nil,
          "type"=>"feature",
          "attributes"=>{
            "external_id"=>"123a",
            "magnitude"=>5.2,
            "place"=>"Atlantis",
            "time"=>1712416582640,
            "tsunami"=>0,
            "mag_type"=>"ml",
            "title"=>"M 2.3 - 14 km E of Coso Junction, CA123",
            "coordinates"=>{
              "longitude"=>-117.7916667,
              "latitude"=>36.0268333
            }
          },
          "links"=>{
            "external_url"=>"http://localhost/earthquake/123a"
          }
        },
        {
          "id"=>nil,
          "type"=>"feature",
          "attributes"=>{
            "external_id"=>"1234a",
            "magnitude"=>2.0,
            "place"=>"Andromeda",
            "time"=>1712416582640,
            "tsunami"=>1,
            "mag_type"=>"mm",
            "title"=>"M 2.3 - 14 km E of Coso Junction, CA1234",
            "coordinates"=>{
              "longitude"=>-117.7916667,
              "latitude"=>36.0268333
            }
          },
          "links"=>{
            "external_url"=>"http://localhost/earthquake/1234a"
          }
        },
        {
          "id"=>nil,
          "type"=>"feature",
          "attributes"=>{
            "external_id"=>"1235a",
            "magnitude"=>8.2,
            "place"=>"Kepler",
            "time"=>1712416582640,
            "tsunami"=>0,
            "mag_type"=>"mo",
            "title"=>"M 2.3 - 14 km E of Coso Junction, CA1235",
            "coordinates"=>{
              "longitude"=>-117.7916667,
              "latitude"=>36.0268333
            }
          },
          "links"=>{
            "external_url"=>"http://localhost/earthquake/1235a"
          }
        }
      ],
      "pagination"=>{
        "current_page"=>1,
        "total"=>10,
        "per_page"=>3
      }
    }
    features = get_serializer_features_array
    ser = SerializerSet.new(object_set: features, current_page: 1, total: 10, per_page: 3).format_set
    puts ser
    assert ser==expected_format
  end

  def get_serializer_features_array
    features = [
      Feature.new(
        external_id: "123a",
        magnitude: 5.2,
        place: "Atlantis",
        time: 1712416582640,
        url: "http://localhost/earthquake/123a",
        tsunami: 0,
        mag_type: "ml",
        title: "M 2.3 - 14 km E of Coso Junction, CA123",
        longitude: -117.7916667,
        latitude: 36.0268333
      ),
      Feature.new(
        external_id: "1234a",
        magnitude: 2,
        place: "Andromeda",
        time: 1712416582640,
        url: "http://localhost/earthquake/1234a",
        tsunami: 1,
        mag_type: "mm",
        title: "M 2.3 - 14 km E of Coso Junction, CA1234",
        longitude: -117.7916667,
        latitude: 36.0268333
      ),
      Feature.new(
        external_id: "1235a",
        magnitude: 8.2,
        place: "Kepler",
        time: 1712416582640,
        url: "http://localhost/earthquake/1235a",
        tsunami: 0,
        mag_type: "mo",
        title: "M 2.3 - 14 km E of Coso Junction, CA1235",
        longitude: -117.7916667,
        latitude: 36.0268333
      ),
    ]
    return features.map do |feature|
      FeatureSerializer.new(feature)
    end
  end
end
