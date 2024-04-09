require 'minitest/autorun'
require 'minitest/hooks/test'
require_relative '../spec_helper'
require_relative '../../src/models/feature.model'
require_relative '../../src/services/comment_service'
require_relative '../../src/errors/feature_does_not_exist_error'
include Models
include CustomErrors

##
# CommentService class with "generate_basic_comment_report" method tests
class CommentServiceGenerateBasicCommentReportSpec < Minitest::Test
  include Minitest::Hooks

  def before_all
    features = get_dummy_features
    features.each do |feature|
      feature.save
    end
    comments = get_dummy_comments
    comments.each do |comment|
      comment.save
    end
    @comment_service = Services::CommentService.instance
  end

  def after_all
    DB[:comments].delete
    DB[:features].delete
  end

  def test_generate_basic_comment_report_with_correct_format
    expected_result = {
      "data"=>[
        "Comment with id 1 to feature with id 1 and title M 2.3 - 14 km E of Coso Junction, CA123",
        "Comment with id 2 to feature with id 2 and title M 2.3 - 14 km E of Coso Junction, CA1234",
        "Comment with id 3 to feature with id 1 and title M 2.3 - 14 km E of Coso Junction, CA123",
        "Comment with id 4 to feature with id 2 and title M 2.3 - 14 km E of Coso Junction, CA1234"
      ]
    }
    comment_report = @comment_service.generate_basic_comment_report

    assert_equal expected_result, comment_report
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
