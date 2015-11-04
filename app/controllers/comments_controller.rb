class CommentsController < ApplicationController
  def index
    comments = Comment.all
    @star5 = Comment.where(rating: "5")
    @star4 = Comment.where(rating: "4")
    @star3 = Comment.where(rating: "3")
    @star2 = Comment.where(rating: "2")
    @star1 = Comment.where(rating: "1")
    @star0 = Comment.where(rating: nil)
  end

  def new
    @c = Comment.new
  end

  def create
    @c = Comment.new(comment_params)
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
