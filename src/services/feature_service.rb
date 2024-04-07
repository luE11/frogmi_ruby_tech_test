require_relative "../models/feature.model"
require_relative "../../helpers/http_client_helper"

module Services
  class FeatureService
    include HttpClientHelper

    def fetch_and_save_features(url)
      data = do_get(url)
      if !data.nil?
        obj = data['features'].collect do |feature|
          props = feature['properties']
          geometry = feature['geometry']
          props.slice('mag', 'place', 'time', 'url', 'tsunami', 'magType', 'title')
            .merge!({ 'id': feature['id'], 'longitude': geometry['coordinates'][0], 'latitude': geometry['coordinates'][1]})
        end
        puts obj
        # dataset massive insert
      end
    end

  end
end
