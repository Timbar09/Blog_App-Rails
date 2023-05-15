class PostsController < ApplicationController
  def index
    find_user
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
    find_user
    find_post
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
