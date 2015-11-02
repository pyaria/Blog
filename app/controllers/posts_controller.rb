class PostsController < ApplicationController
  def index
    @p = Post.all
  end

  def new
    @p = Post.new
  end

  def create
    @p = Post.new(params.require(:post).permit([:title, :body, :public]))
    if @p.save
      redirect_to post_path(@p)
    else
      render :new
    end
  end

  def show
    @p = Post.find(params[:id])
  end

  def edit
    @p = Post.find(params[:id])
  end

  def update
    edit
    @p.update(params.require(:post).permit([:title, :body, :public]))
    if @p.save
      @message = "Post updated!"
      redirect_to(root_path)
    else
      flash[:notice] = "Update failed..."
      render :edit
    end
  end

  def destroy
    @p = Post.find(params[:id])
    @p.destroy
    redirect_to(root_path, notice: "Questions deleted successfully")
  end
end
