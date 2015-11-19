class CommentlikesController < ApplicationController
  before_action :comment, :find_post
  before_action :authenticate_user

  def create
    commentlike = current_user.commentlikes.new
    commentlike.comment = @comment
    if commentlike.save
      LikesMailer.notify_comment_creator(commentlike).deliver_later
      redirect_to post_path(@post), notice: "Comment like saved!"
    else
      redirect_to post_path(@post), notice: "Comment like not saved!"
    end
  end

  def destroy
    commentlike = Commentlike.find params[:id]
    if commentlike.destroy
      redirect_to post_path(@post), notice: "Comment unliked!"
    else
      redirect_to post_path(@post), notice: "Comment unlike not saved!"
    end
  end

  private
  def comment
    @comment = Comment.find params[:comment_id]
  end

  def find_post
    @post = Post.find @comment.post_id
  end

end
