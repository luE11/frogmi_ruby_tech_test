module RequestErrorResponseHelper
  def create_error_response(code: 500, type: "Error", details: "No details provided", path:)
    return {
      "code" => code,
      "type" => type,
      "details" => details,
      "path" => path
    }
  end
end
