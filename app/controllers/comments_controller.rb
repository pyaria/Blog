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
      redirect_to post_path(@post)
    else
      render "posts/show"
    end
  end

  def show
    @c = Comment.find(params[:id])
    @p = @c.post_id
  end

  def edit
    @c = Comment.find(params[:id])
  end

  def update
    @c = Comment.new(comment_params)
    p = @c.post_id
    if @c.save
      redirect_to post_path(p)
    else
      render :edit
    end
  end

  def destroy
    @c = Comment.find(params[:id])
    @c.destroy
    redirect_to comments_path
  end

  private
  def comment_params
    params.require(:comment).permit([:title, :rating, :body])
  end
end
