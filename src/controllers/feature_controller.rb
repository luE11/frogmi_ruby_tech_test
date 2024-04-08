require_relative '../services/feature_service'
require_relative '../../helpers/request_params_helper'
require_relative '../../helpers/request_error_response_helper'
require_relative '../../src/errors/invalid_magtype_value_error'
include Services
include CustomErrors

module Controllers
  class FeatureController < Sinatra::Base
    include RequestParamsHelper
    include RequestErrorResponseHelper

    def initialize(app)
      super(app)
      @feature_service = FeatureService.instance
    end

    before do
      content_type 'application/json'
    end

    get "/features" do
      mag_type = params['mag_type']
      page = number_or_nil(params['page'])
      per_page = number_or_nil(params['per_page'])
      begin
        res = @feature_service.get_serialized_features(mag_type: mag_type, page: page, per_page: per_page)
        return res.to_json
      rescue InvalidMagTypeValueError => e
        return halt 400, create_error_response(
            code: 400, type: "ParamError", message: e.message, path: request.fullpath
          ).to_json
      end
      return halt 500, "Internal error"
    end
  end
end
