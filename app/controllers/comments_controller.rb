class CommentsController < ApplicationController
  before_action :authenticate_user, except: [:index, :show]

  def index
    @comments = Comment.all
    @ratedComments = {}
    5.downto(0) do |n|
      @ratedComments["#{n}"] = (Comment.where(rating: n))
    end
  end

  def create
    @post = Post.find(params[:post_id])
    @comment = Comment.new(comment_params)
    @comment.user = current_user
    #@comment = current_user.comments.new(comment_params)
    @comment.post = @post
    if @comment.rating == nil
      @comment.rating = 0
    end
    if @comment.save
      redirect_to post_path(@post), notice: "Comment saved!"
    else
      render "posts/show"
    end
  end

  def show
    @comment = Comment.find(params[:id])
    @post = @comment.post_id
  end

  def edit
    @comment = Comment.find(params[:id])
    @post = Post.find(params[:post_id])
  end

  def update
    @comment = Comment.find(params[:id])
    @comment.post_id = params[:post_id]
    if @comment.update(comment_params)
      redirect_to post_path(params[:post_id]), notice: "Comment updated!"
    else
      render :edit
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy
    redirect_to post_path(params[:post_id]), notice: "Comment deleted!"
  end

  private
  def comment_params
    params.require(:comment).permit([:title, :rating, :body, :post_id, :user_id])
  end
end
