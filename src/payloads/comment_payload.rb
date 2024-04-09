require_relative '../../helpers/request_params_helper'

##
# Input comment creation payload class with validation purposes
class CommentPayload
  include RequestParamsHelper

  attr_accessor :message, :feature_id
  def initialize(message:, feature_id:)
    @message = message
    @feature_id = feature_id
  end

  ##
  # Checks if payload has errors, returning them in a String array.
  # An empty array is returned if there're no errors
  def errors
    err = []
    if @message.nil?
      err.push("message field is required")
    elsif @message.empty?
      err.push("message field must not be empty")
    end
    cast_feature_id = number_or_nil(@feature_id)
    if @feature_id.nil?
      err.push("feature_id field is required")
    elsif cast_feature_id.nil?
      err.push("feature_id field must be a number")
    end
    @feature_id = cast_feature_id
    return err
  end

end
