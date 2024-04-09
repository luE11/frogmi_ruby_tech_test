require 'sinatra/base'
require "./src/controllers/feature_controller"
require "./src/controllers/comment_controller"
include Controllers

##
# Application main class. Includes Feature and Comment Controllers
class Server < Sinatra::Base
  use FeatureController
  use CommentController

  FRONT_END_HTML_RELATIVE_LOCATION = './client/dist/client/index.html'

  set :public_folder, "./client/dist/client"

  ##
  # Serves frontend build Angular HTML
  get "/" do
    send_file FRONT_END_HTML_RELATIVE_LOCATION
  end

end
