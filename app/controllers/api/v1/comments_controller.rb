class Api::V1::CommentsController < ApplicationController
  def index
    begin
      @post = Post.find(params[:post_id])
      @comments = @post.comments
      render json: @comments
    rescue ActiveRecord::RecordNotFound
      render json: 'No comments found for this post'
    end
  end

  def create
    @comment = Comment.new(comment_params)
    @comment.author = @current_user
    @comment.post = Post.find(params[:post_id])
    if @comment.save
      render json: { status: 'Success', data: @comment }
    else
      render json: { status: 'Failure', error: @comment.errors.full_messages }
    end
  end

  def comment_params
    params.require(:comment).permit(:text)
  end
end
