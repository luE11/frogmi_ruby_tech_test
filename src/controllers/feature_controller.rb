require_relative '../services/feature_service'
require_relative '../../helpers/request_params_helper'
include Services

module Controllers
  class FeatureController < Sinatra::Base
    include RequestParamsHelper

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
      res = @feature_service.get_serialized_features(mag_type: mag_type, page: page, per_page: per_page)
      return res.to_json
    end
  end
end
