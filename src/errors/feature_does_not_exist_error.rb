module CustomErrors
  class FeatureDoesNotExistError < StandardError
    def initialize(msg="Feature does not exists")
      super
    end
  end

end
