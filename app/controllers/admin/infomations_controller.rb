class Admin::InfomationsController < ApplicationController
before_action :authenticate_admin!
before_action :set_infomation, only: [:edit, :update, :destroy]

  def new
    @infomation = Infomation.new
  end

  def create
    @infomation = Infomation.new(infomation_params)
    @infomation.save
    redirect_to public_about_path
  end

  def index
    @infomations = Infomation.all
  end

  def edit
  end

  def update
    @infomation.update(infomation_params)
    redirect_to public_about_path
  end

  def destroy
    @infomation.destroy
    redirect_to request.referer
  end

  private

  def set_infomation
    @infomation = Infomation.find(params[:id])
  end

  def infomation_params
    params.require(:infomation).permit(:content)
  end
end
