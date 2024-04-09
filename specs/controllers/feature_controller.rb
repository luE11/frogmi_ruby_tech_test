require_relative '../spec_helper'
require_relative "../../server"
require 'minitest/autorun'
require 'minitest/hooks/test'
require 'rack/test'

##
# Set of FeatureController tests
class FeatureControllerTest < Minitest::Test
  include Rack::Test::Methods
  include Minitest::Hooks

  ##
  # To run application into mock server
  def app
    Server
  end

  ##
  # Seeds test features before start running tests
  def before_all
    features = get_dummy_features
    features.each do |feature|
      feature.save
    end
  end

  ##
  # Remove all feature records inserted by tests execution
  def after_all
    DB[:features].delete
  end

  ##
  # Activates GET /api/features endpoint and asserts that application returns features of query with default params
  def test_get_features_no_params
    get '/api/features'
    body = JSON.parse(last_response.body)
    features = body["data"]
    pagination = body["pagination"]
    assert last_response.ok?
    assert_equal 10, features.length
    assert_equal 10, pagination["total"]
    assert_equal 10, pagination["per_page"]
    assert_equal 1, pagination["current_page"]
  end

  ##
  # Activates GET /api/features endpoint with valid params and asserts that application returns expected features list
  def test_get_features_valid_params
    get '/api/features', :mag_type => 'mi', :per_page => 2, :page => 2
    body = JSON.parse(last_response.body)
    features = body["data"]
    pagination = body["pagination"]
    assert last_response.ok?
    assert_equal 2, features.length
    assert_equal 4, pagination["total"]
    assert_equal 2, pagination["per_page"]
    assert_equal 2, pagination["current_page"]
  end

  ##
  # Activates GET /api/features endpoint with invalid mag_type type and asserts that application
  # returns error response with HTTP 400 code (Bad Request)
  def test_get_features_invalid_params
    get '/api/features', :mag_type => 3
    errors = JSON.parse(last_response.body)
    assert !last_response.ok?
    assert_equal 400, last_response.status
    assert_equal "ParamError", errors["type"]
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

end
