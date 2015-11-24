class LikesController < ApplicationController
  before_action :post
  before_action :authenticate_user

  def create
    like = current_user.likes.new
    like.post = @post
    respond_to do |format|
      if like.save
        LikesMailer.notify_post_creator(like).deliver_later
        format.html{redirect_to post_path(@post), notice: "Thank you for liking!"}
        format.js {render :create_success}
      else
        format.html{redirect_to post_path(@post), alert: "Unable to like!"}
        format.js {render :create_failure}
      end
    end
  end

  def destroy
    like = @post.like_for(current_user)
    like.destroy
    respond_to do |format|
      format.html{redirect_to post_path(@post), notice: "You've unliked this post!"}
      format.js { render }
    end
  end


  private
  def post
    @post = Post.find params[:post_id]
  end
end
