class CommentsController < ApplicationController
  before_action :find_user, only: %i[index create]
  before_action :find_post, only: %i[index create destroy]

  def index
    @comments = @post.comments
    render json: @comments
  end

  def new
    @comment = Comment.new
  end

  def create
    comment = Comment.new(comment_params)
    comment.author = current_user
    comment.post = @post

    if comment.save
      respond_to do |format|
        format.html { redirect_to user_post_path(@user, @post), notice: 'Comment created.' }
        format.json { render json: comment }
      end
    else
      respond_to do |format|
        format.html { render :new, alert: 'Comment not created.' }
        format.json { render json: comment.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @comment = @post.comments.find(params[:id])

    if @comment.destroy
      redirect_to user_post_path(@post.author, @post), notice: 'Comment deleted.'
    else
      redirect_to user_post_path(@post.author, @post), alert: 'Comment not deleted.'
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
