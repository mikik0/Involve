require 'bundler'
Bundler.require

require './app'
run Sinatra::Application

Time.zone = 'Tokyo'
ActiveRecord::Base.default_timezone = :local