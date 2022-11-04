class CommentsController < ApplicationController
  def create
    @post = Post.find(params[:post_id])
    new_comment = current_user.comments.new(post_id: @post.id,
                                            user_id: current_user.id, text: comment_text)
    if new_comment.save
      redirect_to "/users/#{@post.user_id}/posts/#{@post.id}", notice: 'Success Comment Saved!'
    else
      render :new, status: 'Error occured with Comment!'
    end
  end

  def new
    @comment = Comment.new
    @post = Post.find(params[:post_id])
  end

  def edit
    @comment = Comment.find(params[:id])
  end

  def update
     @comment = Comment.find params[:id]
    if @comment.update comment_text
      redirect_to user_post_path(@post.user_id, @post.id), notice: 'Post edited successfully!'
    else
      render :new
    end

  end

  def destroy
    @comment = Comment.find(params[:id])
    @post = Post.find(@comment.post_id)
    @post.comments_counter -= 1
    if @comment.destroy
      flash[:notice] = 'Comment deleted!'
    else
      flash[:alert] = 'Failed to delete comment!'
    end
    redirect_to user_post_path(current_user, @post.id), notice: 'comment deleted successfully!'
    # redirect_back(fallback_location: root_path)
  end

  private

  def comment_text
    params.require(:comments).permit(:text)[:text]
  end
end
