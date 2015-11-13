class Comment < ActiveRecord::Base
  before_save :validate_body_rating

  belongs_to :post
  belongs_to :user
  private
  def validate_body_rating
    :body != nil or :rating != nil
  end
end
