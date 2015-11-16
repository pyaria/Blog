class CommentlikesController < ApplicationController
  before_action :comment

  def create
    commentlike = current_user.commentlikes.new
    post = Post.find comment.post_id
    commentlike.comment = comment
    if commentlike.save
      LikesMailer.notify_comment_creator(commentlike).deliver_later
      redirect_to post_path(post), notice: "Comment like saved!"
    else
      redirect_to post_path(post), notice: "Comment like not saved!"
    end
  end

  def destroy
    post = Post.find comment.post_id
    commentlike = Commentlike.find params[:id]
    if commentlike.destroy
      redirect_to post_path(post), notice: "Comment unliked!"
    else
      redirect_to post_path(post), notice: "Comment unlike not saved!"
    end
  end

  private
  def comment
    Comment.find params[:comment_id]
  end

end
