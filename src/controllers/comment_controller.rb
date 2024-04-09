require_relative '../services/comment_service'
require_relative '../../helpers/request_error_response_helper'
require_relative '../../src/errors/feature_does_not_exist_error'
require_relative '../payloads/comment_payload'
include Services
include CustomErrors

module Controllers
  ##
  # CommentController class which exposes Comment services
  class CommentController < Sinatra::Base
    include RequestErrorResponseHelper

    def initialize(app)
      super(app)
      @comment_service = CommentService.instance
    end

    before do
      content_type 'application/json'
    end

    ##
    # Posts a new comment by passing a JSON body with message and feature_id to the request.
    # Returns an error response with HTTP 400 code if payload has invalid values.
    # Returns an error response with HTTP 404 code if feature_id value doesn't match with a existing Feature record
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
        return halt 404, create_error_response(
            code: 404, type: "Entity not found error", details: e.message, path: request.fullpath
          ).to_json
      end
    end

    ##
    # Returns a simple report containing data about every comment stored into database
    get "/comments/report" do
      return @comment_service.generate_basic_comment_report.to_json
    end
  end
end
