class PostsController < ApplicationController
  def index
    @p = Post.order(:created_at).page params[:page]
  end

  def new
    @p = Post.new
  end

  def create
    @p = Post.new(params.require(:post).permit([:title, :body, :public]))
    if @p.save
      @message = "Post created!"
      flash[:notice] = "Post Created!"
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
      redirect_to(root_path, notice: "Post updated!")
    else
      render(:edit, notice: "Post update failed...")
    end
  end

  def destroy
    @p = Post.find(params[:id])
    @p.destroy
    redirect_to(root_path, notice: "Post deleted successfully")
  end
end
