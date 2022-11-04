class UsersController < ApplicationController
  protect_from_forgery
  before_action :authenticate_user!

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
  end

  def posts
    @user = User.find(params[:id])
    @posts = Post.where(user_id: params[:id])
  end
end
