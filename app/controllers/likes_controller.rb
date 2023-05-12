class LikesController < ApplicationController
  def create
    like = Like.new
    post = Post.find(params[:post_id])
    user = User.find(params[:user_id])
    like.post = post
    like.author = current_user

    if like.save
      redirect_to user_post_path(user, post), notice: 'Like created successfully'
    else
      redirect_to user_post_path(user, post), alert: like.errors.full_messages.join(', ')
    end
  end
end
