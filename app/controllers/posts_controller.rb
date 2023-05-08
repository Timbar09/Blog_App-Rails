class PostsController < ApplicationController
  def index
    select_user
    @posts = @user.posts
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
end
