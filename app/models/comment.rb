class Comment < ActiveRecord::Base
  before_save :validate_body_rating

  private
  def validate_body_rating
    :body != nil or :rating != nil
  end
end
