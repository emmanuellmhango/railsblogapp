class Api::V1::PostsController < ApplicationController
  def index
    begin
      @posts = @user.posts.order(created_at: :asc)
      render json: @posts
    rescue ActiveRecord::RecordNotFound
      render json: 'Posts not found'
    end
  end
end
