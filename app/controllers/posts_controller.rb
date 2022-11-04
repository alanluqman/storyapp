class PostsController < ApplicationController
  def index
    # @posts = Post.where(user_id: params[@user.id])
    @posts = Post.all
  end

  def show
    @post = Post.find(params[:id])
  end

  def new
    @post = Post.new
  end

  def edit
    authorize! :edit, @post
    @post = Post.find params[:id]
  end

  def update
    authorize! :update, @post
     @post = Post.find params[:id]

    if @post.update post_data
      redirect_to user_post_path(@post.user_id, @post.id), notice: 'Post edited successfully!'
    else
      render :new
    end

  end 

  def destroy
    hello guys
    authorize! :destroy, @post
    @post.destroy
  end

  def create
    new_post = current_user.posts.new(post_data)
    new_post.likes_counter = 0
    new_post.comments_counter = 0
    respond_to do |format|
      format.html do
        if new_post.save
          redirect_to "/users/#{new_post.user_id}/posts/", notice: 'Success Post Saved!'
        else
          render :new, status: 'Error occured with Post!'
        end
      end
    end
  end

  private

  def post_data
    params.require(:posts).permit(:title, :text)
  end
end
