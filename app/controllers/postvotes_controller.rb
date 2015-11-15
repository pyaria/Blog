class PostvotesController < ApplicationController

  def create
    post = Post.find params[:post_id]
    vote = current_user.postvotes.new(postvote_params)
    vote.post = post
    if vote.save
      redirect_to post_path(post), notice: "Voted!"
    else
      redirect_to post_path(post), alert: "Vote failed!"
    end
  end

  def update
    post = Post.find params[:post_id]
    vote = current_user.postvotes.find params[:id]
    if vote.update(postvote_params)
      redirect_to post_path(post), notice: "Vote updated!"
    else
      redirect_to post_path(post), alert: "Vote update failed!"
    end
  end

  def destroy
    post = Post.find params[:post_id]
    vote = current_user.postvotes.find params[:id]
    vote.destroy
    redirect_to post_path(post), notice: "Vote removed!"
  end

  private
  def postvote_params
    params.require(:postvote).permit(:vote)
  end
end
