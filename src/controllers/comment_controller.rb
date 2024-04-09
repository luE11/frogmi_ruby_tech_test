require_relative '../services/comment_service'
require_relative '../../helpers/request_error_response_helper'
require_relative '../../src/errors/feature_does_not_exist_error'
require_relative '../payloads/comment_payload'
include Services
include CustomErrors

module Controllers
  class CommentController < Sinatra::Base
    include RequestErrorResponseHelper

    def initialize(app)
      super(app)
      @comment_service = CommentService.instance
    end

    before do
      content_type 'application/json'
    end

    post "/comments" do
      body = JSON.parse(request.body.read)
      payload = CommentPayload.new(message: body["message"], feature_id: body["feature_id"])
      errors = payload.errors
      if !errors.empty?
        return halt 400, create_error_response(
          code: 400, type: "Invalid payload", details: errors, path: request.fullpath
          ).to_json
      end
      begin
        return @comment_service.create_comment_serialized(message: payload.message, feature_id: payload.feature_id).to_json
      rescue FeatureDoesNotExistError => e
        full_message = e.message + ". With feature_id: #{payload.feature_id}"
        return halt 404, create_error_response(
            code: 404, type: "Not found error", details: full_message, path: request.fullpath
          ).to_json
      end
    end

    get "/comments/report" do
      return @comment_service.generate_basic_comment_report.to_json
    end
  end
end
