require 'bundler/setup'
Bundler.require

if development?
  ActiveRecord::Base.establish_connection("sqlite3:db/development.db")
end

class User < ActiveRecord::Base
  has_secure_password
  has_many :posts
  has_many :follows
  has_many :comments
  has_many :dones, dependent: :destroy
  validates :name, presence: true
  validates :password,
    length: { in: 3..30 }
end