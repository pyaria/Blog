class LikesController < ApplicationController
  def create
    post = Post.find params[:post_id]
    like = current_user.likes.new
    like.post = post
    if like.save
      redirect_to post_path(post), notice: "Thank you for liking!"
    else
      redirect_to post_path(post), alert: "Unable to like!"
    end
  end

  def destroy
    post = Post.find params[:post_id]
    like = post.like_for(current_user)
    like.destroy
    redirect_to post_path(post), notice: "You've unliked this post!"
  end

end
