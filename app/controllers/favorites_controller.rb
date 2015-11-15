class FavoritesController < ApplicationController

  def create
    post = Post.find params[:post_id]
    favorite = current_user.favorites.new
    favorite.post = post
    if favorite.save
      redirect_to post_path(post), notice: "Post favorited!"
    else
      redirect_to post_path(post), alert: "Favorite failed!"
    end
  end

  def destroy
    post = Post.find params[:post_id]
    favorite = Favorite.find params[:id]
    favorite.destroy
    redirect_to post_path(post), notice: "Post unfavorited!"
  end

end
