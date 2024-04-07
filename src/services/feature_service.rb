require_relative "../models/feature.model"
require_relative "../../helpers/http_client_helper"

module Services
  class FeatureService
    include HttpClientHelper

    def fetch_and_save_features(url)
      data = do_get(url)
      if !data.nil?
        feature_set = format_fetched_features(data['features'])
        store_multiple_features_from_hash(feature_set)
      else
        puts "Couldn't fetch data from #{url}"
      end
    end

    def format_fetched_features(data)
      validation_model = Models::Feature.new()
      feature_set = data.collect do |feature|
        formatted_hash = format_feature_from_hash(feature)
        formatted_hash if validate_hash(formatted_hash, validation_model)
      end
      puts "#{feature_set.length-feature_set.compact.length} invalid records skipped"
      return feature_set.compact
    end

    def format_feature_from_hash(hash)
      props = hash['properties']
      geometry = hash['geometry']
      return props.slice('mag', 'place', 'time', 'url', 'tsunami', 'magType', 'title')
      .merge!({
        'external_id'=> hash['id'],
        'longitude'=> geometry['coordinates'][0],
        'latitude'=> geometry['coordinates'][1]
      })
    end

    def validate_hash(hash, model)
      model.set_fields(hash, hash.keys)
      return model.valid?
    end

    def store_multiple_features_from_hash(features)
      puts "Attempting to store #{features.length} features"
      DB[:features].insert_conflict.multi_insert(features)
    end

  end
end
