# frozen_string_literal: true

class Public::SessionsController < Devise::SessionsController
  # before_action :configure_sign_in_params, only: [:create]
  before_action :customer_state,only:[:create]
  # before_action :authenticate_customer!, except: [:index]

  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  # def create
  #   super
  # end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
  def after_sign_in_path_for(resource)
    public_path(current_customer.id)
  end

  def new_guest
    customer = Customer.guest
    sign_in customer
    redirect_to root_path, notice: "ゲストユーザーとしてログインしました。"
  end

  protected

  def customer_state
    @customer = Customer.find_by(email:params[:customer][:email])
    return if !@customer
    if @customer.valid_password?(params[:customer][:password]) && @customer.is_active == false
    redirect_to new_customer_registration_path
    end
  end
end
