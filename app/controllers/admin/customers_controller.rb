class Admin::CustomersController < ApplicationController
  before_action :set_customer

  def show
  end

  def edit
  end

  def update
    @customer.update!(customer_params)
    redirect_to admin_path(@customer.id)
  end

  private

  def set_customer
    @customer = Customer.find(params[:id])
  end

  def customer_params
    params.require(:customer).permit(:last_name,:first_name,:last_name_kana,:first_name_kana,:email,:is_active)
  end

end
