class User < ActiveRecord::Base
  has_secure_password
  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :nullify

  has_many :likes, dependent: :destroy
  has_many :liked_posts, through: :likes, source: :post

  has_many :commentlikes, dependent: :nullify
  has_many :comments, through: :commentlikes

  has_many :favorites, dependent: :nullify
  has_many :favorited_posts, through: :favorites, source: :post
  attr_accessor :hello

  validates :email, presence: true, uniqueness: true
end
