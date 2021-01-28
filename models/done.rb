require 'bundler/setup'
Bundler.require

if development?
  ActiveRecord::Base.establish_connection("sqlite3:db/development.db")
end

class Done < ActiveRecord::Base
  belongs_to :user
  belongs_to :blog
end