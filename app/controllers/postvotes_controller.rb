class PostvotesController < ApplicationController
  before_action :find_post, :authenticate_user
  before_action :vote, except: :create

  def create
    @vote = current_user.postvotes.new(postvote_params)
    @vote.post = @post
    respond_to do |format|
      if @vote.save
        VotesMailer.notify_post_creator(@vote).deliver_later
        format.html{redirect_to post_path(@post), notice: "Voted!"}
        format.js{render :create_success}
      else
        format.html{redirect_to post_path(@post), alert: "Vote failed!"}
        format.js{render :create_failure}
      end
    end
  end

  def update
    @vote = vote
    respond_to do |format|
      if @vote.update(postvote_params)
        format.html{redirect_to post_path(@post), notice: "Vote updated!"}
        format.js{render :create_success}
      else
        format.html{redirect_to post_path(@post), alert: "Vote update failed!"}
        format.js{render :update_failure}
      end
    end
  end

  def destroy
    vote.destroy
    respond_to do |format|
      format.html{redirect_to post_path(@post), notice: "Vote removed!"}
      format.js{render}
    end
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
