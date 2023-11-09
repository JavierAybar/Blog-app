class CommentsController < ApplicationController
  load_and_authorize_resource
  before_action :find_user
  before_action :find_post

  def new
    @comment = @post.comments.new
  end

  def create
    @comment = @post.comments.new(comment_params)
    @comment.user = @user
    if @comment.save
      redirect_to user_post_path(@user, @post)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @comment = @post.comments.find(params[:id])
    @comment.destroy
    redirect_to user_posts_path(@user)
  end

  private

  def comment_params
    params.require(:comment).permit(:text)
  end

  def find_user
    @user = current_user
  end

  def find_post
    @post = Post.find(params[:post_id])
  end
end
