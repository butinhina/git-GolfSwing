class Public::CustomersController < ApplicationController

  def show
    @customer = Customer.find(params[:id])
    @post_videos = @customer.post_videos.published.page(params[:page]).reverse_order

    if params[:tag_ids].present?
      @post_videos = []
      params[:tag_ids].each do |key, value|
        @post_videos += Tag.find_by(name: key).post_videos if value == "1"
        @post_videos.each do |post_video|
          if post_video.customer_id != current_customer.id
          @post_videos.delete(post_video)
          end
        end
      end
      @post_videos.uniq!
    end
  end

  def edit
    @customer = current_customer
  end

  def update
    @customer = current_customer
    @customer.update(customer_params)
    redirect_to public_path(current_customer.id)
  end

  def unsubscribe
  end

  def withdraw
    @customer = current_customer
    @customer.update(is_active :false)
    reset_session
    redirect_to root_path
  end

  private
  def customer_params
    params.require(:customer).permit(:last_name, :first_name, :last_name_kana, :first_name_kana, :email, :nickname, :height, :birth_dat, :holding_ball, :history, :forte_club, :message, :profile_image)
  end
end
