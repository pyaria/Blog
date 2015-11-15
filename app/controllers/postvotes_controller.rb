class PostvotesController < ApplicationController
  before_action :post,
  before_action :vote, except: :create

  def create
    vote = current_user.postvotes.new(postvote_params)
    vote.post = post
    if vote.save
      redirect_to post_path(post), notice: "Voted!"
    else
      redirect_to post_path(post), alert: "Vote failed!"
    end
  end

  def update
    if vote.update(postvote_params)
      redirect_to post_path(post), notice: "Vote updated!"
    else
      redirect_to post_path(post), alert: "Vote update failed!"
    end
  end

  def destroy
    vote.destroy
    redirect_to post_path(post), notice: "Vote removed!"
  end

  private
  def postvote_params
    params.require(:postvote).permit(:vote)
  end

  def post
    Post.find params[:post_id]
  end

  def vote
    current_user.postvotes.find params[:id]
  end
end
