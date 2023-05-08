class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def show
    select_user
  end

  private

  def select_user
    @user = User.find(params[:id])
  end
end
