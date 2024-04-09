require 'minitest/autorun'
require 'minitest/hooks/test'
require_relative '../spec_helper'
require_relative '../../src/models/feature.model'
require_relative '../../src/services/comment_service'
require_relative '../../src/errors/feature_does_not_exist_error'
include Models
include CustomErrors

##
# CommentService class with "create_comment" method tests
class CommentServiceCreateCommentSpec < Minitest::Test
  include Minitest::Hooks

  def before_all
    save_dummy_feature
    @comment_service = Services::CommentService.instance
  end

  def after_all
    DB[:comments].delete
    DB[:features].delete
  end

  def test_create_comment_existing_feature
    message= "What a nice feature!"
    feature_id= 1

    comment = @comment_service.create_comment(message: message, feature_id: feature_id)
    comment_feature = comment.feature

    assert_equal message, comment.message
    assert_equal feature_id, comment.feature_id
    assert !comment_feature.nil?
    assert_equal comment_feature.id, feature_id
  end

  def test_create_comment_unexisting_feature_raises_error
    message= "What a nice feature!"
    feature_id= 2

    assert_raises FeatureDoesNotExistError do
      @comment_service.create_comment(message: message, feature_id: feature_id)
    end
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
