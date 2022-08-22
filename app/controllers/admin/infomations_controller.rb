class Admin::InfomationsController < ApplicationController

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
    @infomation = Infomation.find(params[:id])
  end

  def update
    Infomation.find(params[:id]).update(infomation_params)
    redirect_to public_about_path
  end

  def destroy
    Infomation.find(params[:id]).destroy
    redirect_to request.refere
  end
  private

  def infomation_params
    params.require(:infomation).permit(:content)
  end
end
