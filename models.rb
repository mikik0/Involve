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
  validates :name, presence: true
  validates :password,
    length: { in: 3..30 }
end

class Post < ActiveRecord::Base
  belongs_to :user
  belongs_to :category
  has_many :follows
  has_many :comments
end

class Category < ActiveRecord::Base
  has_many :posts
end

class Follow < ActiveRecord::Base
  belongs_to :user
  belongs_to :post
  validates_uniqueness_of :post_id, scope: :user_id
end

class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :post
end
