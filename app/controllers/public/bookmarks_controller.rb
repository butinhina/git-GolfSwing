class Public::BookmarksController < ApplicationController
  before_action :authenticate_customer!

  def create
    @post_video = PostVideo.find(params[:post_video_id])
    bookmark = @post_video.bookmarks.new(customer_id: current_customer.id)
    bookmark.save
    redirect_to request.referer
  end

  def destroy
    @post_video = PostVideo.find(params[:post_video_id])
    bookmark = @post_video.bookmarks.find_by(customer_id: current_customer.id)
    if bookmark.present? # bookmark.present?を挟んでいるのは、２度押しのエラーを回避するためです。
      bookmark.destroy
      redirect_to request.referer
    end
  end

  def index
    @bookmarks = Bookmark.where(customer_id: current_customer.id)
  end
end
