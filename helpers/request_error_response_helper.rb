module RequestErrorResponseHelper
  ##
  # Creates an error object to attach to response when an error happens
  def create_error_response(code: 500, type: "Error", details: "No details provided", path:)
    return {
      "code" => code,
      "type" => type,
      "details" => details,
      "path" => path
    }
  end
end
