class Post < ActiveRecord::Base
  validates :title, presence: true, uniqueness: {scope: :body}
  validates :body, presence: true, uniqueness: {scope: :title}

  has_many :comments, dependent: :destroy
  paginates_per 10
end
