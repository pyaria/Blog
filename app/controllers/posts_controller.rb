class PostsController < ApplicationController
  before_action :authenticate_user, except: [:index, :show]
  before_action :authorize, only: [:edit, :update, :destroy]
  def index
    @p = Post.order('created_at ASC').page params[:page]
  end

  def new
    @p = Post.new
  end

  def create
    @p = Post.new(post_params)
    if @p.save
      @message = "Post created!"
      flash[:notice] = "Post Created!"
      redirect_to post_path(@p)
    else
      render :new
    end
  end

  def show
    @comment = Comment.new
    @p = Post.find(params[:id])
    @c = @p.comments
  end

  def edit
    @p = Post.find(params[:id])
  end

  def update
    edit
    @p.update(post_params)
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

  private
  def post_params
    params.require(:post).permit([:title, :body, :public])
  end
end
