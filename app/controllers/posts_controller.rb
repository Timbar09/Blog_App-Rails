class PostsController < ApplicationController
  def index
    select_user
    @posts = @user.posts
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
    select_user
    select_posts
  end

  private

  def select_user
    @user = User.find(params[:user_id])
  end

  def select_posts
    @post = Post.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:title, :text)
  end
end
