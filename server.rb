require 'sinatra/base'
require "./src/controllers/feature_controller"
include Controllers

class Server < Sinatra::Base
  use FeatureController

end
