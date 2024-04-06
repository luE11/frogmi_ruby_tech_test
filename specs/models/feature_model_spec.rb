require 'minitest/autorun'
require_relative '../spec_helper'
require_relative '../../src/models/feature.model'

##
# Set of Feature model validation tests
#
class FeatureModelSpec < Minitest::Test
  EMPTY_FIELD_ERROR_MESSAGE="can't be empty"

  ##
  # Creates a Feature object with valid attribute values.
  # Then asserts that the Feature instance is valid
  def test_feature_validation_success
    feature = Models::Feature.new(
      mag: 5.2,
      place: "Atlantis",
      time: 1712416582640,
      url: "http://localhost/earthquake",
      tsunami: 0,
      magType: "ml",
      title: "M 2.3 - 14 km E of Coso Junction, CA",
      longitude: -117.7916667,
      latitude: 36.0268333
    ).tap{ |o| o.id = "123a" }

    assert feature.valid?
  end

  ##
  # Creates a Feature object without setting any of the required attributes.
  # Then asserts there're 7 errors matching the nil fields
  def test_feature_validation_wrong_attributes
    feature = Models::Feature.new(
      mag: 5.2,
      time: 1712416582640,
      tsunami: 0
    )

    assert !feature.valid?
    assert feature.errors.length==7
    assert feature.errors.on(:id)[0]==EMPTY_FIELD_ERROR_MESSAGE
    assert feature.errors.on(:title)[0]==EMPTY_FIELD_ERROR_MESSAGE
    assert feature.errors.on(:url)[0]==EMPTY_FIELD_ERROR_MESSAGE
    assert feature.errors.on(:place)[0]==EMPTY_FIELD_ERROR_MESSAGE
    assert feature.errors.on(:magType)[0]==EMPTY_FIELD_ERROR_MESSAGE
    assert feature.errors.on(:latitude)[0]==EMPTY_FIELD_ERROR_MESSAGE
    assert feature.errors.on(:longitude)[0]==EMPTY_FIELD_ERROR_MESSAGE
  end

  ##
  # Creates a Feature object with wrong range values for mag, latitude and longitude
  # Then asserts the three fields has errors
  def test_feature_validation_attributes_out_of_range
    feature = Models::Feature.new(
      mag: 11.8,
      place: "Atlantis",
      time: 1712416582640,
      url: "http://localhost/earthquake",
      tsunami: 0,
      magType: "ml",
      title: "M 2.3 - 14 km E of Coso Junction, CA",
      longitude: -190.7916667,
      latitude: 96.0268333
    ).tap{ |o| o.id = "123a" }

    assert !feature.valid?
    assert feature.errors.length==3
    assert feature.errors.on(:mag).length==1
    assert feature.errors.on(:latitude).length==1
    assert feature.errors.on(:longitude).length==1
  end
end
