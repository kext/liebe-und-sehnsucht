class User < ActiveRecord::Base
  has_secure_password

  validates :name, presence: true, uniqueness: true

  has_many :posts
end
