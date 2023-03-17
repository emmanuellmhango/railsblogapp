class CommentsController < ApplicationController
  load_and_authorize_resource

  def new
    @current_user = current_user
    @new_comment = Comment.new
  end

  def create
    @post = Post.find(params[:post_id])
    @new_comment = Comment.create(comment_params)
    @new_comment.author_id = current_user.id
    @new_comment.post_id = @post.id
    if @new_comment.save
      redirect_to user_post_path(current_user.id, @post.id)
    else
      render :new, alert: 'Error'
    end
  end

  def destroy
    @comment = Comment.find(params[:id])

    if @comment.destroy
      flash[:notice] = 'Comment deleted successfully!'
      redirect_to user_post_path(user_id: current_user.id, id: @comment.post_id)
    else
      flash[:alert] = @comment.errors.full_messages.first if @comment.errors.any?
      render :show, status: 400
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:text).merge(author_id: current_user.id)
  end
end
