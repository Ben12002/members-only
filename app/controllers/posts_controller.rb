class PostsController < ApplicationController
  before_action :authenticate_user!, except: [:index]

  def index
    @posts = Post.all
  end

  def new
    @post = Post.new
  end

  def create
    # Do this instead of Post.new(post_params), so that user_id gets filled automatically.
    @post = current_user.posts.build(post_params)

    if @post.save
      redirect_to root_path
    else
      render :new, status: :unprocessable_entity
    end
  end


  private

  def post_params
    params.require(:post).permit(:title, :body)
  end
end
