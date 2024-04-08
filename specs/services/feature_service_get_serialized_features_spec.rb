require 'minitest/autorun'
require 'minitest/hooks/test'
require_relative '../spec_helper'
require_relative '../../src/models/feature.model'
require_relative '../../src/services/feature_service'
include Models
include CustomErrors

##
# FeatureService class with "get_serialized_features" method tests
class FeatureServiceGetSerializedFeaturesSpec < Minitest::Test
  include Minitest::Hooks

  def before_all
    DB.transaction(rollback: :always, auto_savepoint: true){super}
    features = get_dummy_features
    features.each do |feature|
      feature.save
    end
    @feature_service = Services::FeatureService.instance
  end

  def after_all
    DB[:features].delete
  end

  ##
  # Executes the FeatureService "get_serialized_features" method with query filter as parameters.
  # Then checks if the output matches the required format
  def test_get_serialized_features
    expected_result = get_expected_result
    mag_type = "md"
    page = 1
    per_page = 5

    res = @feature_service.get_serialized_features(mag_type:mag_type, page: page, per_page: per_page)

    assert_equal(expected_result, res)
  end

  def get_dummy_features
    return [
      Feature.new(
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
      ).tap { |o| o.id = 1 },
      Feature.new(
        external_id: "1234a",
        magnitude: 2,
        place: "Andromeda",
        time: 1712416582640,
        url: "http://localhost/earthquake/1234a",
        tsunami: 1,
        mag_type: "mb",
        title: "M 2.3 - 14 km E of Coso Junction, CA1234",
        longitude: -117.7916667,
        latitude: 36.0268333
      ).tap { |o| o.id = 2 },
      Feature.new(
        external_id: "1235a",
        magnitude: 8.2,
        place: "Kepler",
        time: 1712416582640,
        url: "http://localhost/earthquake/1235a",
        tsunami: 0,
        mag_type: "mi",
        title: "M 2.3 - 14 km E of Coso Junction, CA1235",
        longitude: -117.7916667,
        latitude: 36.0268333
      ).tap { |o| o.id = 3 },
      Feature.new(
        external_id: "1236a",
        magnitude: 5.2,
        place: "Atlantis",
        time: 1712416582640,
        url: "http://localhost/earthquake/123a",
        tsunami: 0,
        mag_type: "md",
        title: "M 2.3 - 14 km E of Coso Junction, CA123",
        longitude: -117.7916667,
        latitude: 36.0268333
      ).tap { |o| o.id = 4 },
      Feature.new(
        external_id: "1237a",
        magnitude: 2,
        place: "Andromeda",
        time: 1712416582640,
        url: "http://localhost/earthquake/1234a",
        tsunami: 1,
        mag_type: "mb",
        title: "M 2.3 - 14 km E of Coso Junction, CA1234",
        longitude: -117.7916667,
        latitude: 36.0268333
      ).tap { |o| o.id = 5 },
      Feature.new(
        external_id: "1238a",
        magnitude: 8.2,
        place: "Kepler",
        time: 1712416582640,
        url: "http://localhost/earthquake/1235a",
        tsunami: 0,
        mag_type: "mi",
        title: "M 2.3 - 14 km E of Coso Junction, CA1235",
        longitude: -117.7916667,
        latitude: 36.0268333
      ).tap { |o| o.id = 6 },
      Feature.new(
        external_id: "1239a",
        magnitude: 5.2,
        place: "Atlantis",
        time: 1712416582640,
        url: "http://localhost/earthquake/123a",
        tsunami: 0,
        mag_type: "md",
        title: "M 2.3 - 14 km E of Coso Junction, CA123",
        longitude: -117.7916667,
        latitude: 36.0268333
      ).tap { |o| o.id = 7 },
      Feature.new(
        external_id: "12310a",
        magnitude: 2,
        place: "Andromeda",
        time: 1712416582640,
        url: "http://localhost/earthquake/1234a",
        tsunami: 1,
        mag_type: "mb",
        title: "M 2.3 - 14 km E of Coso Junction, CA1234",
        longitude: -117.7916667,
        latitude: 36.0268333
      ).tap { |o| o.id = 8 },
      Feature.new(
        external_id: "12311a",
        magnitude: 8.2,
        place: "Kepler",
        time: 1712416582640,
        url: "http://localhost/earthquake/1235a",
        tsunami: 0,
        mag_type: "mi",
        title: "M 2.3 - 14 km E of Coso Junction, CA1235",
        longitude: -117.7916667,
        latitude: 36.0268333
      ).tap { |o| o.id = 9 },
      Feature.new(
        external_id: "12312a",
        magnitude: 8.2,
        place: "Kepler",
        time: 1712416582640,
        url: "http://localhost/earthquake/1235a",
        tsunami: 0,
        mag_type: "mi",
        title: "M 2.3 - 14 km E of Coso Junction, CA1235",
        longitude: -117.7916667,
        latitude: 36.0268333
      ).tap { |o| o.id = 10 },
    ]
  end

  def get_expected_result
    return {
      "data"=>[
        {
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
        },
        {
          "id"=>4,
          "type"=>"feature",
          "attributes"=>{
            "external_id"=>"1236a",
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
        },
        {
          "id"=>7,
          "type"=>"feature",
          "attributes"=>{
            "external_id"=>"1239a",
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
      ],
      "pagination"=>{
        "current_page"=>1,
        "total"=>10,
        "per_page"=>5
      }
    }
  end
end
