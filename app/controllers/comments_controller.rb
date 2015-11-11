class CommentsController < ApplicationController
  def index
    @comments = Comment.all
    @ratedComments = {}
    5.downto(0) { |n|
      @ratedComments["#{n}"] = (Comment.where(rating: n))
    }
  end

  def new
    @c = Comment.new
  end

  def create
    @c = Comment.new(comment_params)
    if @c.rating == nil
      @c.rating = 0
    end
    if @c.save
      redirect_to comments_path
    else
      render :new
    end
  end

  def show
    @c = Comment.find(params[:id])
  end

  def edit
    @c = Comment.find(params[:id])
  end

  def update
    @c = Comment.new(comment_params)
    if @c.save
      redirect_to comments_path
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
