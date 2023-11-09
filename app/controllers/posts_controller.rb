class PostsController < ApplicationController
  load_and_authorize_resource
  before_action :find_user, only: %i[index show destroy]

  def index
    @posts = @user.posts.includes(:comments)
  end

  def find_user
    @user = User.find(params[:user_id])
  end

  def show
    @post = @user.posts.find(params[:id])
  end

  def new
    @user = current_user
    @post = @user.posts.new
  end

  def create
    @post = current_user.posts.new(post_params)
    if @post.save
      redirect_to user_posts_path(current_user)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @post = current_user.posts.find(params[:id])
    @post.likes.destroy_all
    @post.comments.destroy_all
    @post.destroy
    redirect_to user_posts_path(current_user)
  end

  private

  def post_params
    params.require(:post).permit(:title, :text)
  end
end
