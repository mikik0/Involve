require 'bundler/setup'
Bundler.require

if development?
  ActiveRecord::Base.establish_connection("sqlite3:db/development.db")
end

class Follow < ActiveRecord::Base
  belongs_to :user
  belongs_to :post
  validates_uniqueness_of :post_id, scope: :user_id
end