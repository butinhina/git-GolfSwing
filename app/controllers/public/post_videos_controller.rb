class Public::PostVideosController < ApplicationController
before_action :authenticate_customer!, except: [:index, :show]

  def new
    @post_video = PostVideo.new
  end

  def create
    @post_video = PostVideo.new(post_video_params)
    @post_video.customer_id = current_customer.id
    if @post_video.save
      redirect_to public_post_video_path(@post_video.id)
    else
      render :new
    end
  end

  def index
    @post_videos = PostVideo.published.page(params[:page]).reverse_order

    if params[:tag]
      Tag.create(name: params[:tag])
    end

    if params[:tag_ids].present?
      @post_videos = []
      params[:tag_ids].each do |key, value|
        @post_videos += Tag.find_by(name: key).post_videos if value == "1"
      end
      @post_videos.uniq!
    end
  end

  def confirm
    @post_videos = current_customer.post_videos.draft.page(params[:page]).reverse_order
  end

  def show
    @post_video = PostVideo.find(params[:id])
    @customer = @post_video.customer
    @post_comment = PostComment.new

  end

  def edit
    @post_video = PostVideo.find(params[:id])
  end

  def update
    @post_video = PostVideo.find(params[:id])
    if @post_video.update(post_video_params)
      redirect_to public_post_video_path(@post_video.id), notice: "投稿を更新しました"
    else
      render :edit
    end
  end

  def destroy
    @post_video = PostVideo.find(params[:id])
    @post_video.destroy
    redirect_to public_path(current_customer.id)
  end

  def search
    @post_videos = PostVideo.published.search(params[:keyword])
    @keyword = params[:keyword]
  end

  def my_search
    @post_videos = PostVideo.published.search(params[:keyword])
    @keyword = params[:keyword]
  end

  private

  def post_video_params
    params.require(:post_video).permit(:customer_id, :report, :video, :status, tag_ids: [])
  end

  protected

  def guest?
    if current_customer == Customer.guest
      redirect_to root_path
    end
  end

end
