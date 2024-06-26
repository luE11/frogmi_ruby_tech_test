require 'dotenv'
Dotenv.load

require_relative "../config/setup_database"
require_relative "../src/services/feature_service"

namespace :features do
  desc "Fetches from external Earthquake API and stores feature records on database"
  task :import do
    url = ENV['EARTHQUAKE_API_ENDPOINT']
    Services::FeatureService.instance.fetch_and_save_features(url)
  end
end
