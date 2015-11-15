class CommentlikesController < ApplicationController

  def create
    comment = Comment.find params[:comment_id]
    commentlike = current_user.commentlikes.new
    post = Post.find comment.post_id
    commentlike.comment = comment
    if commentlike.save
      redirect_to post_path(post), notice: "Comment like saved!"
    else
      redirect_to post_path(post), notice: "Comment like not saved!"
    end
  end

  def destroy
    comment = Comment.find params[:comment_id]
    post = Post.find comment.post_id
    commentlike = Commentlike.find params[:id]
    if commentlike.destroy
      redirect_to post_path(post), notice: "Comment unliked!"
    else
      redirect_to post_path(post), notice: "Comment unlike not saved!"
    end
  end

end
