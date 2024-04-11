require 'sequel'

original_verbose = $VERBOSE
$VERBOSE = nil

begin
  DB = nil

  if ENV['PROFILE'] == 'development'
    DB = Sequel.connect('sqlite://earthq.db')
  elsif ENV['PROFILE'] == 'production'
    DB = Sequel.connect(
      adapter: ENV['DATABASE_ADAPTER']|| 'sqlite',
      host: ENV['DATABASE_HOST'],
      port: ENV['DATABASE_PORT'],
      database: ENV['DATABASE_NAME'],
      user: ENV['DATABASE_USER'],
      password: ENV['DATABASE_PASSWORD'])
    engine = DB.class.name.split("::")[1]
    if(engine.downcase=="mysql2")
      # Setting max_allowed_packet mysql variable to 4194304 to handle features operations
      DB.run "SET GLOBAL max_allowed_packet=4194304;" # Increase 4 times max_allowed_packet variable
      DB.disconnect
      # Restart connection to update variable value
      DB = Sequel.connect(
        adapter: ENV['DATABASE_ADAPTER']|| 'sqlite',
        host: ENV['DATABASE_HOST'],
        port: ENV['DATABASE_PORT'],
        database: ENV['DATABASE_NAME'],
        user: ENV['DATABASE_USER'],
        password: ENV['DATABASE_PASSWORD'])
    end

  end
rescue StandardError => e
  puts "Couldn't connect to database. #{e.message}"
else
  $VERBOSE = original_verbose

  puts "Successfully connected to database"

  require_relative 'db_table_creation'

end
