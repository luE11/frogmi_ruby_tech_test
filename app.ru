require 'dotenv'
Dotenv.load

require './config/setup_database'
require './server'

run Server
