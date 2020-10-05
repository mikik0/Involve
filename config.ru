require 'bundler'
Bundler.require

require './app'
run Sinatra::Application

config.time_zone = "Tokyo"
config.active_record.default_timezone = :local