require 'minitest/autorun'
require_relative '../spec_helper'
require_relative '../../src/models/feature.model'

class FeatureTestCase < Minitest::Test
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
end
