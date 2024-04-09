require 'sinatra/base'
require "./src/controllers/feature_controller"
require "./src/controllers/comment_controller"
include Controllers

class Server < Sinatra::Base
  use FeatureController
  use CommentController

  get "/" do
    "Hello"
  end

end
