require_relative '../spec_helper'
require_relative "../../server"
require 'minitest/autorun'
require 'minitest/hooks/test'
require 'rack/test'

class CommentControllerTest < Minitest::Test
  include Rack::Test::Methods
  include Minitest::Hooks

  def app
    Server
  end

  def before_all
    features = get_dummy_features
    features.each do |feature|
      feature.save
    end
    comments = get_dummy_comments
    comments.each do |comment|
      comment.save
    end
  end

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

  def after_all
    clear_database
  end

  def clear_database
    DB[:comments].delete
    DB[:features].delete
  end

  def test_get_comments_report
    get '/comments/report'
    body = JSON.parse(last_response.body)
    report = body["data"]
    assert last_response.ok?
    assert_equal 4, report.length
  end

  def test_post_create_comment_valid_payload
    payload = {
      "message" => "What a nice feature test!",
      "feature_id" => 1
    }
    post '/comments', payload.to_json, { 'CONTENT_TYPE' => 'application/json' }

    comment = JSON.parse(last_response.body)
    assert last_response.ok?
    assert_equal 5, comment["id"]
    assert_equal payload["message"], comment["attributes"]["message"]
    assert_equal payload["feature_id"], comment["attributes"]["feature"]["id"]
  end

  def test_post_create_comment_invalid_payload
    payload = {
      "message" => "",
      "feature_id" => "a"
    }
    post '/comments', payload.to_json, { 'CONTENT_TYPE' => 'application/json' }

    errors = JSON.parse(last_response.body)
    assert !last_response.ok?
    assert_equal 400, last_response.status
    assert_equal "Invalid payload", errors["type"]
    assert_equal 2, errors["details"].length
  end

  def test_post_create_comment_unexisting_feature
    payload = {
      "message" => "Valid message",
      "feature_id" => 10
    }
    post '/comments', payload.to_json, { 'CONTENT_TYPE' => 'application/json' }

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
