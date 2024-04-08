module CustomErrors
  class InvalidMagTypeValueError < StandardError
    def initialize(msg="Invalid mag_type value")
      super
    end
  end

end
