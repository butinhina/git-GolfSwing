class Public::PostVideosController < ApplicationController
before_action :authenticate_customer!, except: [:index, :show]
before_action :set_post_video, only: [:show, :edit, :update, :destroy]

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
    #パラメータがあればindexアクション内でtagsテーブルに保存
    if params[:tag]
      @tag = Tag.create(name: params[:tag])
    elsif @tag.present?
      @tag.save
    end
    #タグのOR検索
    if params[:tag_ids].present?  #tag_idsが存在していたら
        params[:tag_ids].shift
        @post_videos = PostVideo.includes(:post_tags).where(post_tags: {tag_id: params[:tag_ids]}).published.page(params[:page]).reverse_order
    end
  end

  def confirm
    @post_videos = current_customer.post_videos.draft.page(params[:page]).reverse_order #ログイン中のユーザーが下書きしたものだけを取得
  end

  def show
    @customer = @post_video.customer
    @post_comment = PostComment.new
    if @customer != current_customer && @post_video.status == "draft"
      redirect_to public_post_videos_path
    end
  end

  def edit
    if @post_video.customer != current_customer
      redirect_to public_post_videos_path
    end
  end

  def update
    if @post_video.update(post_video_params)
      redirect_to public_post_video_path(@post_video.id), notice: "内容を更新しました。"
    else
      render :edit
    end
  end

  def destroy
    if @post_video.customer != current_customer
      redirect_to public_post_videos_path
    else
      @post_video.destroy
      redirect_to public_customer_path(current_customer.id)
    end
  end

  def search
    @post_videos = PostVideo.published.search(params[:keyword]).page(params[:page])
    @keyword = params[:keyword]
  end

  def my_search
    @post_videos = PostVideo.published.search(params[:keyword]).page(params[:page])
    @keyword = params[:keyword]
  end


  protected

  def set_post_video
    @post_video = PostVideo.find(params[:id])
  end

  private

  def post_video_params
    params.require(:post_video).permit(:customer_id, :report, :video, :status, tag_ids: [])
  end

end
