require 'uri'
require 'net/http'
require 'json'

module HttpClientHelper
  ##
  # Executes a HTTP GET request to a specified endpoint
  #   @param endpoint [String] endpoint
  # @return [Hash|nil]
  def do_get(endpoint)
    uri = URI(endpoint)
    res = Net::HTTP.get_response(uri)
    return res.is_a?(Net::HTTPSuccess) ? JSON.parse(res.body) : nil
  end
end
