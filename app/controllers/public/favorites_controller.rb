class Public::FavoritesController < ApplicationController
  before_action :authenticate_customer!
  def create
    post_video = PostVideo.find(params[:post_video_id])
    favorite = current_customer.favorites.new(post_video_id: post_video.id)
    favorite.save
    redirect_to request.referer
  end





  def destroy
    post_video = PostVideo.find(params[:post_video_id])
    favorite = current_customer.favorites.find_by(post_video_id: post_video.id)
    favorite.destroy
    redirect_to request.referer


  end
end
