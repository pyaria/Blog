class CommentvotesController < ApplicationController
  before_action :comment, :post
  before_action :vote, except: :create
  before_action :authenticate_user

  def create
    vote = current_user.commentvotes.new(vote_params)
    vote.comment = comment
    if vote.save
      VotesMailer.notify_comment_creator(vote).deliver_later
      redirect_to post_path(post), notice: "Vote saved!"
    else
      redirect_to post_path(post), notice: "Vote failed!"
    end
  end

  def update
    if vote.update(vote_params)
      redirect_to post_path(post), notice: "Vote updated!"
    else
      redirect_to post_path(post), notice: "Vote update failed!"
    end
  end

  def destroy
    vote.destroy
    redirect_to post_path(post), notice: "Vote removed!"
  end

  private
  def vote_params
    params.require(:commentvote).permit(:vote)
  end

  def comment
    Comment.find params[:comment_id]
  end

  def vote
    Commentvote.find params[:id]
  end

  def post
    post = comment.post
  end

end
