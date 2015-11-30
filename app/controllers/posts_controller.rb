class PostsController < ApplicationController
  before_action :authenticate_user, except: [:index, :show]
  before_action :find_post, except: [:index, :new, :create]
  before_action :authorize, only: [:edit, :update, :destroy]

  def index
    if user_signed_in?
      @post = Post.where(user_id:
            current_user.id).order("created_at desc").page params[:page]
      @otherposts = Post.order("created_at desc").limit(10)
    else
      @post = Post.order("created_at desc").page params[:page]
    end
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.user = current_user
    if @post.save
      redirect_to post_path(@post), notice: "Post created!"
    else
      render :new, alert: "Post not created!"
    end
  end

  def show
    @comment = Comment.new
    @first_name = @post.user.first_name
    @comments = @post.comments
  end

  def edit
  end

  def update
    if @post.update(post_params)
      redirect_to(post_path(@post), notice: "Post updated!")
    else
      render(:edit, notice: "Post update failed...")
    end
  end

  def destroy
    @post.destroy
    redirect_to(root_path, notice: "Post deleted successfully")
  end

  private
  def post_params
    params.require(:post).permit([:title, :body, :public, :user_id, {category_ids: []}, :image])
  end

  def find_post
    @post = Post.find params[:id]
  end

  def authorize
    redirect_to root_path, notice: "Access denied!" unless can? :manage, @post
  end

end
