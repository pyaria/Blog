class CommentvotesController < ApplicationController
  before_action :comment, :post
  before_action :vote, except: :create
  before_action :authenticate_user

  def create
    @vote = current_user.commentvotes.new(vote_params)
    @vote.comment = @comment
    respond_to do |format|
      if @vote.save
        VotesMailer.notify_comment_creator(@vote).deliver_later
        format.html{redirect_to post_path(post), notice: "Vote saved!"}
        format.js{render :create_success, comment: @comment}
      else
        format.html{redirect_to post_path(post), notice: "Vote failed!"}
        format.js{render :create_failure}
      end
    end
  end

  def update
    respond_to do |format|
      if @vote.update(vote_params)
        format.html{redirect_to post_path(post), notice: "Vote updated!"}
        format.js{render :update_success}
      else
        format.html{redirect_to post_path(post), notice: "Vote update failed!"}
        format.js{render :update_failure}
      end
    end
  end

  def destroy
    @vote.destroy
    respond_to do |format|
      format.html{redirect_to post_path(post), notice: "Vote removed!"}
      format.js{render}
    end
  end

  private
  def vote_params
    params.require(:commentvote).permit(:vote)
  end

  def comment
    @comment = Comment.find params[:comment_id]
  end

  def vote
    @vote = Commentvote.find params[:id]
  end

  def post
    post = comment.post
  end

end
