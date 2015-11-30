class FavoritesController < ApplicationController
  before_action :post

  def create
    favorite = current_user.favorites.new
    favorite.post = @post
    respond_to do |format|
      if favorite.save
        FavoritesMailer.notify_post_creator(favorite).deliver_later
        format.html{redirect_to post_path(@post), notice: "Post favorited!"}
        format.js {render :create_success}
      else
        format.html{redirect_to post_path(@post), alert: "Favorite failed!"}
        format.js {render :create_failure}
      end
    end
  end

  def destroy
    favorite = Favorite.find params[:id]
    favorite.destroy
    respond_to do |format|
      format.html{redirect_to post_path(@post), notice: "Post unfavorited!"}
      format.js {render}
    end
  end

  private
  def post
    @post = Post.find params[:post_id]
  end

end
