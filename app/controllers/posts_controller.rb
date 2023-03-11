class PostsController < ApplicationController
  def index
    @user = User.find(params[:user_id])
    @posts = @user.posts.includes(:comments)
  end

  def show
    @post = Post.find(params[:id])
    @comment = Comment.new(post: @post)
    # @comments = @post.comments.order(created_at: :desc)
    render :show
  end

  def new
    @user = User.find(current_user.id)
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @user = User.find(current_user.id)

    @post.author_id = @user.id
    @post.comments_counter = 0
    @post.likes_counter = 0

    if @post.save
      flash[:notice] = 'Post created successfully.'
      redirect_to user_path(@post.author_id), notice: 'Post created successfully'
    else
      render :new, alert: 'Error creating post'
    end
  end

  private

  def post_params
    params.require(:post).permit(:title, :text)
  end
end
