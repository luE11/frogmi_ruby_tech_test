module RequestErrorResponseHelper
  def create_error_response(code: 500, type: "Error", message: "No message provided", path:)
    return {
      "code" => code,
      "type" => type,
      "message" => message,
      "path" => path
    }
  end
end
