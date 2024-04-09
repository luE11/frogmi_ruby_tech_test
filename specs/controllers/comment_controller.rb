require_relative '../spec_helper'
require_relative "../../server"
require 'minitest/autorun'
require 'minitest/hooks/test'
require 'rack/test'

##
# Set of FeatureController tests
class CommentControllerTest < Minitest::Test
  include Rack::Test::Methods
  include Minitest::Hooks

  ##
  # To run application into mock server
  def app
    Server
  end

  ##
  # Seeds test features and comments before start running each test
  def setup
    clear_database
    features = get_dummy_features
    features.each do |feature|
      feature.save
    end
    comments = get_dummy_comments
    comments.each do |comment|
      comment.save
    end
  end

  ##
  # Cleans database after executing all tests
  def after_all
    clear_database
  end

  ##
  # Cleans comments and features tables
  def clear_database
    DB[:comments].delete
    DB[:features].delete
  end

  ##
  # Activates GET /api/comments/report endpoint and asserts that application returns a report
  # with stored comments data
  def test_get_comments_report
    get '/api/comments/report'
    body = JSON.parse(last_response.body)
    report = body["data"]
    assert last_response.ok?
    assert_equal 4, report.length
  end

  ##
  # Activates POST /api/features/id/comments endpoint with valid body and asserts that application returns
  # the inserted comment record with its auto-generated id
  def test_post_create_comment_valid_payload
    feature_id = 1
    payload = {
      "message" => "What a nice feature test!"
    }
    post "/api/features/#{id}/comments", payload.to_json, { 'CONTENT_TYPE' => 'application/json' }

    comment = JSON.parse(last_response.body)
    assert last_response.ok?
    assert_equal 5, comment["id"]
    assert_equal payload["message"], comment["attributes"]["message"]
    assert_equal payload["feature_id"], comment["attributes"]["feature"]["id"]
  end

  ##
  # Activates POST /api/features/id/comments endpoint with invalid body and asserts that application returns
  # error response with HTTP 400 code (Bad Request). Validates that response contains info about errors
  def test_post_create_comment_invalid_payload
    feature_id = "a"
    payload = {
      "message" => ""
    }
    post "/api/features/#{id}/comments", payload.to_json, { 'CONTENT_TYPE' => 'application/json' }

    errors = JSON.parse(last_response.body)
    assert !last_response.ok?
    assert_equal 400, last_response.status
    assert_equal "Invalid payload", errors["type"]
    assert_equal 2, errors["details"].length
  end

  ##
  # Activates POST /api/features/id/comments endpoint with valid body but the feature_id doesn't match any feature record in database
  # and asserts that application returns error response with HTTP 404 code (Resource not found).
  def test_post_create_comment_unexisting_feature
    feature_id = 10
    payload = {
      "message" => "Valid message"
    }
    post "/api/features/#{id}/comments", payload.to_json, { 'CONTENT_TYPE' => 'application/json' }

    errors = JSON.parse(last_response.body)

    assert !last_response.ok?
    assert_equal 404, last_response.status
    assert_equal "Entity not found error", errors["type"]
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
      ).tap { |o| o.id = 2 }
    ]
  end

  def get_dummy_comments
    return [
      Comment.new(
        message: "What a nice feature!",
        feature_id: 1,
      ).tap { |o| o.id = 1 },
      Comment.new(
        message: "This is the best feature!",
        feature_id: 2,
        ).tap { |o| o.id = 2 },
      Comment.new(
        message: "Magnitude of 5.2? D:",
        feature_id: 1,
      ).tap { |o| o.id = 3 },
      Comment.new(
        message: "Nice!",
        feature_id: 2,
      ).tap { |o| o.id = 4 },
    ]
  end

end
