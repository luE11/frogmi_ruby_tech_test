module RequestParamsHelper
  ##
  # Tries to cast string to integer. If string is not a numeric string, returns nil
  def number_or_nil(string)
    Integer(string || '')
  rescue ArgumentError
    nil
  end

end
