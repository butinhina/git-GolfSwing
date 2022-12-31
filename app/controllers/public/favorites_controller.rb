class Public::FavoritesController < ApplicationController
  before_action :authenticate_customer!

  def create
    @post_video = PostVideo.find(params[:post_video_id])
    favorite = @post_video.favorites.new(customer_id: current_customer.id)
    if favorite.save
    else
      redirect_to request.referer
    end
  end

  def destroy
    @post_video = PostVideo.find(params[:post_video_id])
    favorite = @post_video.favorites.find_by(customer_id: current_customer.id)
    if favorite.present?
      favorite.destroy
    else
      redirect_to request.referer
    end
  end
end
