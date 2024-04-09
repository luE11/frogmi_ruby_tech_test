module CustomErrors
  ##
  # Raises when a feature object doesn't exist
  class FeatureDoesNotExistError < StandardError
    def initialize(msg="Feature does not exists")
      super
    end
  end

end
