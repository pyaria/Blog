class User < ActiveRecord::Base
  has_secure_password
  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :nullify
  attr_accessor :hello

  validates :email, presence: true, uniqueness: true
end
