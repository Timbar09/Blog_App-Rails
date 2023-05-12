class CommentsController < ApplicationController
  before_action :find_user, only: [:create]
  before_action :find_post, only: [:create]

  def new
    @comment = Comment.new
  end

  def create
    comment = Comment.new(comment_params)
    comment.author = current_user
    comment.post = @post

    if comment.save
      redirect_to user_post_path(@user, @post), notice: 'Comment created.'
    else
      render :new, alert: 'Comment not created.'
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:text)
  end

  def find_user
    @user = User.find(params[:user_id])
  end

  def find_post
    @post = Post.find(params[:post_id])
  end
end
