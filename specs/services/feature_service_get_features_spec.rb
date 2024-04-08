require 'minitest/autorun'
require 'minitest/hooks/test'
require_relative '../spec_helper'
require_relative '../../src/models/feature.model'
require_relative '../../src/services/feature_service'
require_relative '../../src/errors/invalid_magtype_value_error'
include Models
include CustomErrors

##
# FeatureService class with "get_features" method tests
class FeatureServiceGetFeaturesSpec < Minitest::Test
  include Minitest::Hooks

  def before_all
    features = get_dummy_features
    features.each do |feature|
      feature.save
    end
    @feature_service = Services::FeatureService.instance
  end

  def after_all
    DB[:features].delete
  end

  def test_get_features_string_valid_magtype
    mag_type = "md"
    page = 1
    per_page = 20

    res = @feature_service.get_features(mag_type:mag_type, page: page, per_page: per_page)
    assert_equal(3, res.length)
  end

  def test_get_features_string_invalid_magtype_should_raise_exception
    mag_type = "m9"
    page = 1
    per_page = 20

    assert_raises InvalidMagTypeValueError do
      @feature_service.get_features(mag_type:mag_type, page: page, per_page: per_page)
    end
  end

  def test_get_features_invalid_magtype_class_should_raise_exception
    mag_type = 14.78
    page = 1
    per_page = 20

    assert_raises InvalidMagTypeValueError do
      @feature_service.get_features(mag_type:mag_type, page: page, per_page: per_page)
    end
  end

  def test_get_features_no_magtype
    page = 1
    per_page = 20

    res = @feature_service.get_features(page: page, per_page: per_page)
    assert_equal(10, res.length)
  end

  def test_get_features_empty_string_magtype
    mag_type = ""
    page = 1
    per_page = 20

    res = @feature_service.get_features(mag_type:mag_type, page: page, per_page: per_page)
    assert_equal(10, res.length)
  end

  def test_get_features_empty_array_magtype
    mag_type = []
    page = 1
    per_page = 20

    assert_raises InvalidMagTypeValueError do
      @feature_service.get_features(mag_type:mag_type, page: page, per_page: per_page)
    end
  end

  def test_get_features_valid_array_values_magtype
    mag_type = ["md", "mi"]
    page = 1
    per_page = 20

    res = @feature_service.get_features(mag_type:mag_type, page: page, per_page: per_page)
    assert_equal(7, res.length)
  end

  def test_get_features_invalid_array_values_magtype
    mag_type = ["m1", "m0", "m2"]
    page = 1
    per_page = 20

    assert_raises InvalidMagTypeValueError do
      @feature_service.get_features(mag_type:mag_type, page: page, per_page: per_page)
    end
  end

  def test_get_features_partially_valid_array_values_magtype
    mag_type = ["md", "m1"]
    page = 1
    per_page = 20

    res = @feature_service.get_features(mag_type:mag_type, page: page, per_page: per_page)
    assert_equal(3, res.length)
  end

  def get_dummy_features
    return [
      Feature.new(
        external_id: "123a",
        magnitude: 5.2,
        place: "Atlantis",
        time: 1712416582640,
        url: "http://localhost/earthquake/123a",
        tsunami: 0,
        mag_type: "md",
        title: "M 2.3 - 14 km E of Coso Junction, CA123",
        longitude: -117.7916667,
        latitude: 36.0268333
      ).tap { |o| o.id = 1 },
      Feature.new(
        external_id: "1234a",
        magnitude: 2,
        place: "Andromeda",
        time: 1712416582640,
        url: "http://localhost/earthquake/1234a",
        tsunami: 1,
        mag_type: "mb",
        title: "M 2.3 - 14 km E of Coso Junction, CA1234",
        longitude: -117.7916667,
        latitude: 36.0268333
      ).tap { |o| o.id = 2 },
      Feature.new(
        external_id: "1235a",
        magnitude: 8.2,
        place: "Kepler",
        time: 1712416582640,
        url: "http://localhost/earthquake/1235a",
        tsunami: 0,
        mag_type: "mi",
        title: "M 2.3 - 14 km E of Coso Junction, CA1235",
        longitude: -117.7916667,
        latitude: 36.0268333
      ).tap { |o| o.id = 3 },
      Feature.new(
        external_id: "1236a",
        magnitude: 5.2,
        place: "Atlantis",
        time: 1712416582640,
        url: "http://localhost/earthquake/123a",
        tsunami: 0,
        mag_type: "md",
        title: "M 2.3 - 14 km E of Coso Junction, CA123",
        longitude: -117.7916667,
        latitude: 36.0268333
      ).tap { |o| o.id = 4 },
      Feature.new(
        external_id: "1237a",
        magnitude: 2,
        place: "Andromeda",
        time: 1712416582640,
        url: "http://localhost/earthquake/1234a",
        tsunami: 1,
        mag_type: "mb",
        title: "M 2.3 - 14 km E of Coso Junction, CA1234",
        longitude: -117.7916667,
        latitude: 36.0268333
      ).tap { |o| o.id = 5 },
      Feature.new(
        external_id: "1238a",
        magnitude: 8.2,
        place: "Kepler",
        time: 1712416582640,
        url: "http://localhost/earthquake/1235a",
        tsunami: 0,
        mag_type: "mi",
        title: "M 2.3 - 14 km E of Coso Junction, CA1235",
        longitude: -117.7916667,
        latitude: 36.0268333
      ).tap { |o| o.id = 6 },
      Feature.new(
        external_id: "1239a",
        magnitude: 5.2,
        place: "Atlantis",
        time: 1712416582640,
        url: "http://localhost/earthquake/123a",
        tsunami: 0,
        mag_type: "md",
        title: "M 2.3 - 14 km E of Coso Junction, CA123",
        longitude: -117.7916667,
        latitude: 36.0268333
      ).tap { |o| o.id = 7 },
      Feature.new(
        external_id: "12310a",
        magnitude: 2,
        place: "Andromeda",
        time: 1712416582640,
        url: "http://localhost/earthquake/1234a",
        tsunami: 1,
        mag_type: "mb",
        title: "M 2.3 - 14 km E of Coso Junction, CA1234",
        longitude: -117.7916667,
        latitude: 36.0268333
      ).tap { |o| o.id = 8 },
      Feature.new(
        external_id: "12311a",
        magnitude: 8.2,
        place: "Kepler",
        time: 1712416582640,
        url: "http://localhost/earthquake/1235a",
        tsunami: 0,
        mag_type: "mi",
        title: "M 2.3 - 14 km E of Coso Junction, CA1235",
        longitude: -117.7916667,
        latitude: 36.0268333
      ).tap { |o| o.id = 9 },
      Feature.new(
        external_id: "12312a",
        magnitude: 8.2,
        place: "Kepler",
        time: 1712416582640,
        url: "http://localhost/earthquake/1235a",
        tsunami: 0,
        mag_type: "mi",
        title: "M 2.3 - 14 km E of Coso Junction, CA1235",
        longitude: -117.7916667,
        latitude: 36.0268333
      ).tap { |o| o.id = 10 },
    ]
  end
end
