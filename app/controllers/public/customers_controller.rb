class Public::CustomersController < ApplicationController

  def show
    @customer = current_customer
  end

  def edit
    @customer = current_customer
  end

  def update
    @customer = current_customer
    @customer.update(customer_params)
    redirect_to public_customers_my_page_path
  end

  def unsubscribe
  end

  def withdraw
    @customer = current_customer
    @customer.update(is_active :false)
    reset_session
    redirect_to root_path
  end

  def acount
    @customer = current_customer
    @post_videos = @customer.post_videos
  end

  private
  def customer_params
    params.require(:customer).permit(:last_name, :first_name, :last_name_kana, :first_name_kana, :email, :nickname, :height, :birth_dat, :holding_ball, :history, :forte_club, :message, :profile_image)
  end
end
