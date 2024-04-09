require_relative '../../helpers/request_params_helper'

class CommentPayload
  include RequestParamsHelper

  attr_accessor :message, :feature_id
  def initialize(message:, feature_id:)
    @message = message
    @feature_id = feature_id
  end

  def errors
    err = []
    if @message.nil?
      err.push("Message field is required")
    elsif @message.empty?
      err.push("Message field must not be empty")
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
