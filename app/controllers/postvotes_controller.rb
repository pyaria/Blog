class PostvotesController < ApplicationController
  before_action :find_post, :authenticate_user
  before_action :vote, except: :create

  def create
    vote = current_user.postvotes.new(postvote_params)
    vote.post = @post
    if vote.save
      VotesMailer.notify_post_creator(vote).deliver_later
      redirect_to post_path(@post), notice: "Voted!"
    else
      redirect_to post_path(@post), alert: "Vote failed!"
    end
  end

  def update
    if vote.update(postvote_params)
      redirect_to post_path(@post), notice: "Vote updated!"
    else
      redirect_to post_path(@post), alert: "Vote update failed!"
    end
  end

  def destroy
    vote.destroy
    redirect_to post_path(@post), notice: "Vote removed!"
  end

  private
  def postvote_params
    params.require(:postvote).permit(:vote)
  end

  def find_post
    @post = Post.find params[:post_id]
  end

  def vote
    current_user.postvotes.find params[:id]
  end
end
