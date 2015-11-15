class Comment < ActiveRecord::Base
  before_save :validate_body_rating

  belongs_to :post
  belongs_to :user

  has_many :commentlikes, dependent: :destroy
  has_many :liking_users, through: :commentlikes, source: :user

  has_many :commentvotes, dependent: :destroy
  has_many :voting_users, through: :commentvotes, source: :user

  def commentlike_for(userid)
    commentlikes.find_by_user_id(userid)
  end

  def commentliked_by(user)
    commentlike_for(user.id).present?
  end

  def commentvote_for(userid)
    commentvotes.find_by_user_id(userid)
  end

  def commentvoted_by(user)
    commentvote_for(user.id).present?
  end

  def vote_total
    commentvotes.select{|v| v.vote?}.count - commentvotes.select{|v| !v.vote?}.count
  end

  private
  def validate_body_rating
    :body != nil or :rating != nil
  end
end
