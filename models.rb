require 'bundler/setup'
Bundler.require

if development?
  ActiveRecord::Base.establish_connection("sqlite3:db/development.db")
end

class User < ActiveRecord::Base
  has_secure_password
  validates :name, presence: true
  validates :password,
    length: { in: 3..30 }
end

class Post < ActiveRecord::Base
  has_many :categories
end

class Category < ActiveRecord::Base
  belongs_to :posts
end
