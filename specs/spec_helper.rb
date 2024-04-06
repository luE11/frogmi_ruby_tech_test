require 'minitest/autorun'
require 'sqlite3'
require 'sequel'

DB = Sequel.sqlite

require_relative '../config/db_table_creation'
