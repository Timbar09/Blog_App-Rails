class PostsController < ApplicationController
  load_and_authorize_resource
  before_action :find_user, only: [:index, :show, :destroy]
  before_action :find_post, only: [:show, :destroy]

  def index
    @posts = @user.posts.includes(:comments)

    respond_to do |format|
      format.html
      format.json { render json: @posts }
    end
  end

  def new
    @post = Post.new
  end

  def create
    post = Post.new(post_params)
    post.author = current_user

    if post.save
      redirect_to user_posts_path(current_user), notice: 'Post created'
    else
      render :new, alert: 'Post not created'
    end
  end

  def show
  end

  def destroy
    if @post.destroy
      redirect_to user_posts_path(current_user), notice: 'Post deleted'
    else
      redirect_to user_posts_path(current_user), alert: 'Post not deleted'
    end
  end

  private

  def find_user
    @user = User.includes(:posts).find(params[:user_id])
  end

  def find_post
    @post = @user.posts.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:title, :text)
  end
end
