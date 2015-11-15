class Post < ActiveRecord::Base
  validates :title, presence: true, uniqueness: {scope: :body}
  validates :body, presence: true, uniqueness: {scope: :title}

  has_many :comments, dependent: :destroy
  belongs_to :user

  has_many :categorizations, dependent: :destroy
  has_many :categories, through: :categorizations

  has_many :likes, dependent: :destroy
  has_many :liking_users, through: :likes, source: :users

  has_many :favorites, dependent: :destroy
  has_many :favoriting_users, through: :favorites, source: :users

  has_many :postvotes, dependent: :destroy
  has_many :voting_users, through: :postvotes, source: :users

  def like_for(userid)
    likes.find_by_user_id(userid)
  end

  def liked_by(user)
    like_for(user.id).present?
  end

  def favorite_for(userid)
    favorites.find_by_user_id(userid)
  end

  def favorited_by(user)
    favorite_for(user.id).present?
  end

  def postvote_for(userid)
    postvotes.find_by_user_id(userid)
  end

  def postvoted_by(user)
    postvote_for(user.id).present?
  end

  def vote_total
    postvotes.select{|v| v.vote?}.count - postvotes.select{|v| !v.vote?}.count
  end

  paginates_per 10
end
