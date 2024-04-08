require 'minitest/autorun'
require_relative '../spec_helper'
require_relative '../../src/models/comment.model'
include Models

##
# Set of Feature model validation tests
#
class CommentModelSpec < Minitest::Test
  EMPTY_FIELD_ERROR_MESSAGE="can't be empty"
  NIL_FIELD_ERROR_MESSAGE="can't be nil"

  ##
  # Creates a Comment object with valid attribute values.
  # Then asserts that the Comment instance is valid
  def test_comment_validation_success
    comment = Comment.new(
      message: "What a nice feature!",
      feature_id: 1,
    )
    assert comment.valid?
  end

  ##
  # Creates a Comment object without setting any of the required attributes.
  # Then asserts there're 2 errors matching the nil fields
  def test_feature_validation_wrong_attributes
    comment = Comment.new()

    assert !comment.valid?
    assert comment.errors.length==2
    assert comment.errors.on(:message)[0]==EMPTY_FIELD_ERROR_MESSAGE
    assert comment.errors.on(:feature_id)[0]==NIL_FIELD_ERROR_MESSAGE
  end

end
