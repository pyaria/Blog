class FavoritesController < ApplicationController
  before_action :post

  def create
    favorite = current_user.favorites.new
    favorite.post = post
    if favorite.save
      FavoritesMailer.notify_post_creator(favorite).deliver_later
      redirect_to post_path(post), notice: "Post favorited!"
    else
      redirect_to post_path(post), alert: "Favorite failed!"
    end
  end

  def destroy
    favorite = Favorite.find params[:id]
    favorite.destroy
    redirect_to post_path(post), notice: "Post unfavorited!"
  end

  private
  def post
    Post.find params[:post_id]
  end

end
