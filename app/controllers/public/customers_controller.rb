class Public::CustomersController < ApplicationController
 before_action :check_guest, only: :withdraw
 before_action :set_current_customer, except: [:show, :check_guest]

  def show
    @customer = Customer.find(params[:id])
    @post_videos = @customer.post_videos.published.page(params[:page]).reverse_order # 投稿したものだけ表示

    if params[:tag_ids].present?
      params[:tag_ids].shift
       @post_videos = PostVideo.includes(:post_tags).where(post_tags: {tag_id: params[:tag_ids]}).where(customer_id: current_customer.id).published.page(params[:page]).reverse_order
      # @post_videos.each do |post_video|
      #   if post_video.customer_id != current_customer.id # @post_videosの中から、current_customerのものだけ表示したい
      #     @post_videos.destroy(post_video)
      #   end
      # end
    end
  end

  def edit
  end

  def update
    if @customer.update(customer_params)
      redirect_to public_customer_path(current_customer.id), notice: "会員情報を更新しました。"
    else
      render :edit
    end
  end

  def unsubscribe
  end

  def withdraw
    @customer.update(is_active: false)
    reset_session
    redirect_to root_path
  end

  def check_guest
    if current_customer == Customer.guest
      redirect_to root_path, alert: 'ゲストユーザーの削除はできません。'
    end
  end

  protected

  def set_current_customer
    @customer = current_customer
  end

  private

  def customer_params
    params.require(:customer).permit(:last_name, :first_name, :last_name_kana, :first_name_kana, :email, :nickname, :height, :birth_dat, :holding_ball, :history, :forte_club, :message, :profile_image)
  end
end
