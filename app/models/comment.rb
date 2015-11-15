class Comment < ActiveRecord::Base
  before_save :validate_body_rating

  belongs_to :post
  belongs_to :user

  has_many :commentlikes, dependent: :destroy
  has_many :liking_users, through: :commentlikes, source: :user

  def commentlike_for(userid)
    commentlikes.find_by_user_id(userid)
  end

  def commentliked_by(user)
    commentlike_for(user.id).present?
  end
  
  private
  def validate_body_rating
    :body != nil or :rating != nil
  end
end
