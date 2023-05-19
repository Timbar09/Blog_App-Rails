class UsersController < ApplicationController
  before_action :find_user, only: [:show]

  def index
    @users = User.all

    respond_to do |format|
      format.html
      format.json { render json: @users }
    end
  end

  def show
    respond_to do |format|
      format.html
      format.json { render json: @user }
    end
  end

  private

  def find_user
    @user = User.find(params[:id])
  end
end
