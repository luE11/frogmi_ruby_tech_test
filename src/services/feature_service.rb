require_relative "../models/feature.model"
require_relative "../../helpers/http_client_helper"
require_relative "../errors/invalid_magtype_value_error"
require_relative "../serializers/feature.serializer"
require_relative "../serializers/serializer_set"
include CustomErrors
include Models

module Services
  ##
  # Service class including Feature model operations. This class applies singleton pattern
  class FeatureService
    include HttpClientHelper

    VALID_MAGTYPE_VALUES = ["md", "ml", "ms", "mw", "me", "mi", "mb", "mlg"]

    @instance = nil

    private_class_method :new

    def self.instance
      if @instance.nil?
        @instance = new
      end
      @instance
    end

    ##
    # Checks if feature exists by given id
    def exists_by_id?(id)
      feature = Feature[id]
      return !feature.nil? && feature.exists?
    end

    ##
    # Gets a set of feature serializers matching query filter and format output to match required format
    def get_serialized_features(mag_type: nil, page: nil, per_page: nil)
      page ||=1
      per_page ||=10
      per_page = 1000 if per_page>1000
      features = get_features(mag_type: mag_type, page: page, per_page: per_page)
      return SerializerSet.new(
        object_set: features_to_serializers(features),
        current_page: page,
        total: get_total_features(mag_type),
        per_page: per_page
      ).format_set
    end

    ##
    # Returns total feature records existing on database
    def get_total_features(mag_type)
      validated_magtype = validate_magtype(mag_type)
      if(!validated_magtype.nil? && validated_magtype.empty?)
        raise InvalidMagTypeValueError.new(
          msg="Invalid mag_type value(s). Valid values are: #{VALID_MAGTYPE_VALUES.join(', ')}"
        )
      end
      if validated_magtype.nil?
        return DB[:features].count
      else
        return DB[:features].where("mag_type": mag_type).count
      end
    end

    ##
    # Maps feature hashes to FeatureSerializer and returns it
    def features_to_serializers(features)
      return features.map do |feature|
        FeatureSerializer.new(feature)
      end
    end

    ##
    # Gets filtered valid mag_type or raise error if mag_type is not a String or Array of Strings with valid values.
    # Then executes and return database query result
    def get_features(mag_type: nil, page: nil, per_page: nil)
      page ||=1
      per_page ||=10
      validated_magtype = validate_magtype(mag_type)
      if(!validated_magtype.nil? && validated_magtype.empty?)
        raise InvalidMagTypeValueError.new(
          msg="Invalid mag_type value(s). Valid values are: #{VALID_MAGTYPE_VALUES.join(', ')}"
        )
      end
      records = select_features(mag_type: validated_magtype, page: page, per_page: per_page)
      return records
    end

    ##
    # Checks if mag_type has a valid value. If mag_type is an array, filters only valid values and return values as an string array
    def validate_magtype(mag_type)
      if mag_type.nil? || (mag_type.instance_of?(String) && mag_type.empty?)
        return nil
      end
      if !mag_type.instance_of?(String) && !mag_type.instance_of?(Array)
        raise InvalidMagTypeValueError.new(
          msg="Invalid mag_type value. Must enter text or text array"
        )
      end
      values = mag_type
      if mag_type.instance_of?(String) && !mag_type.empty?
        values = [mag_type]
      end
      valid_values = values.map do |val|
        val if VALID_MAGTYPE_VALUES.include?(val)
      end
      return valid_values.compact
    end

    ##
    # Executes a database select on features table, filtering by mag_type.
    # Returns a dataset with specified page and items per_page
    def select_features(mag_type:, page:, per_page:)
      page_value = (page-1)*per_page
      if mag_type.nil?
        return DB[:features].limit(per_page, page_value).all
      else
        return DB[:features].where("mag_type": mag_type).limit(per_page, page_value).all
      end
    end

    ##
    # Fetches data from an external API earthquake endpoint and stores features in the database
    def fetch_and_save_features(url)
      data = do_get(url)
      if !data.nil?
        feature_set = format_fetched_features(data['features'])
        store_multiple_features_from_hash(feature_set)
      else
        puts "Couldn't fetch data from #{url}"
      end
    end

    ##
    # Iterates hash array, selecting only the required attributes.
    # Remove invalid entries and returns an array of hashes with feature attributes
    def format_fetched_features(data)
      validation_model = Feature.new()
      feature_set = data.collect do |feature|
        formatted_hash = format_feature_from_hash(feature)
        formatted_hash if validate_hash(formatted_hash, validation_model)
      end
      puts "#{feature_set.length-feature_set.compact.length} invalid records skipped"
      return feature_set.compact
    end

    ##
    # Selects and return only Feature attributes from parameter hash
    def format_feature_from_hash(hash)
      props = hash['properties']
      geometry = hash['geometry']
      return props.slice('place', 'time', 'url', 'tsunami', 'title')
      .merge!({
        'mag_type' => props['magType'],
        'magnitude' => props['mag'],
        'external_id'=> hash['id'],
        'longitude'=> geometry['coordinates'][0],
        'latitude'=> geometry['coordinates'][1]
      })
    end

    ##
    # Validates hash values by using a model instance validation
    def validate_hash(hash, model)
      model.set_fields(hash, hash.keys)
      return model.valid?
    end

    ##
    # Inserts in a database multiple rows of Feature from a Hash array. Ignores duplicates
    def store_multiple_features_from_hash(features)
      puts "Attempting to store #{features.length} features"
      DB[:features].insert_conflict.multi_insert(features)
    end

  end
end
