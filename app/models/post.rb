class Post < ActiveRecord::Base
  validates :title, presence: true, uniqueness: {scope: :body}
  validates :body, presence: true, uniqueness: {scope: :title}
  paginates_per 10
end
