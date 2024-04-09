require 'minitest/autorun'
require_relative '../../src/payloads/comment_payload'

##
# CommentPayload validation tests
#
class CommentPayloadSpec < Minitest::Test

  ##
  # Creates a CommentPayload object with valid attribute values.
  # Then asserts that the payload has no errors
  def test_payload_validation_success
    comment = CommentPayload.new(
      message: "What a nice feature!",
      feature_id: 1,
    )
    assert comment.errors.empty?
  end

  ##
  # Creates a CommentPayload object with invalid attribute values.
  # Then asserts there're 2 errors matching the nil fields
  def test_payload_validation_nil_attributes
    comment =  CommentPayload.new(
      message: nil,
      feature_id: nil,
    )
    errors = comment.errors

    assert !errors.empty?
    assert errors.length==2
    assert errors.include?("message field is required")
    assert errors.include?("feature_id field is required")
  end

  ##
  # Creates a CommentPayload object with invalid attribute values.
  # Then asserts there're 2 errors matching empty message and non numeric feature_id
  def test_payload_validation_empty_and_wrong_type_attributes
    comment =  CommentPayload.new(
      message: "",
      feature_id: "@a",
    )
    errors = comment.errors

    assert !errors.empty?
    assert errors.length==2
    assert errors.include?("message field must not be empty")
    assert errors.include?("feature_id field must be a number")
  end

end
