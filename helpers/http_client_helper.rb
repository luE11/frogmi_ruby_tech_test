require 'uri'
require 'net/http'
require 'json'

module HttpClientHelper
  def do_get(endpoint)
    uri = URI(endpoint)
    res = Net::HTTP.get_response(uri)
    return res.is_a?(Net::HTTPSuccess) ? JSON.parse(res.body) : nil
  end
end
