class Public::HomesController < ApplicationController
  def top
  end

  def about
    @infomations = Infomation.all
  end
  

end