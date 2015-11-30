class CommentlikesController < ApplicationController
  before_action :comment, :find_post
  before_action :authenticate_user

  def create
    commentlike = current_user.commentlikes.new(comment: @comment)
    respond_to do |format|
      if commentlike.save
        LikesMailer.notify_comment_creator(commentlike).deliver_later
        format.html{redirect_to post_path(@post), notice: "Comment like saved!"}
        format.js {render :create_success}
      else
        format.html{redirect_to post_path(@post), notice: "Comment like not saved!"}
        format.js {render :create_failure}
      end
    end
  end

  def destroy
    commentlike = Commentlike.find params[:id]
    respond_to do |format|
      if commentlike.destroy
        format.html{redirect_to post_path(@post), notice: "Comment unliked!"}
        format.js{render :destroy_success}
      else
        format.html{redirect_to post_path(@post), notice: "Comment unlike not saved!"}
        format.js{render :destroy_failure}
      end
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
