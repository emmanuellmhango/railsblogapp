class Api::V1::PostsController < ApplicationController
  def index
    @posts = @user.posts.order(created_at: :asc)
    render json: @posts
  rescue ActiveRecord::RecordNotFound
    render json: 'Posts not found'
  end
end
