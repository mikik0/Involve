require 'bundler/setup'
Bundler.require

if development?
  ActiveRecord::Base.establish_connection("sqlite3:db/development.db")
end

class Post < ActiveRecord::Base
  belongs_to :user
  belongs_to :category
  has_many :dones, dependent: :destroy
  has_many :follows
  has_many :comments
end