class Public::PostCommentsController < ApplicationController
  before_action :authenticate_customer!
  def create
    @post_video = PostVideo.find(params[:post_video_id])
    comment = current_customer.post_comments.new(post_comment_params)
    comment.post_video_id = @post_video.id
    if comment.save
      redirect_to request.referer
    else
      @error_comment = comment
      @post_video = PostVideo.find(params[:post_video_id])
      @customer = @post_video.customer
      @post_comment = PostComment.new
      # redirect_to request.referer
      render 'public/post_videos/show'
    end
  end

  def destroy
    PostComment.find(params[:id]).destroy
    redirect_to request.referer
  end

  private

  def post_comment_params
    params.require(:post_comment).permit(:comment)
  end
end
