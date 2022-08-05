class Public::PostsController < ApplicationController

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.customer_id = current_customer.id
    @post.save
    redirect_to public_posts_path
  end

  def index
    @posts = Post.all
  end

  def show
    @post = Post.find(params[:id])
  end



  private

  def post_params
    params.require(:post).permit(:customer_id, :report, :video)
  end
end
