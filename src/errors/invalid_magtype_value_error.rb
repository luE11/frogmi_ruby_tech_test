module CustomErrors
  ##
  # Raises when mag_type field has an invalid value
  class InvalidMagTypeValueError < StandardError
    def initialize(msg="Invalid mag_type value")
      super
    end
  end

end
