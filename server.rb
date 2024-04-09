require 'sinatra/base'
require "./src/controllers/feature_controller"
require "./src/controllers/comment_controller"
include Controllers

##
# Application main class. Includes Feature and Comment Controllers
class Server < Sinatra::Base
  use FeatureController
  use CommentController

  # TODO:
  get "/" do
    "Hello"
  end

end
