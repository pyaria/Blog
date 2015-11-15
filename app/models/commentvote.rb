class Commentvote < ActiveRecord::Base
  validates :comment_id, uniqueness: {scope: :user_id}
  
  belongs_to :user
  belongs_to :comment
end
