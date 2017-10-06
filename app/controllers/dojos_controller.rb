class DojosController < ApplicationController
  def index
    @dojos = Dojo.all
  end
  
  def new
    @dojo = Dojo.new
  end

  def create
    @dojo = Dojo.new(dojo_params)
    if @dojo.save
      redirect_to "/dojos"
    else
      puts @dojo.errors.full_messages
      render "new.html"
    end
  end

  private
    def dojo_params
      params.require(:dojo).permit(:branch, :street, :city, :state)
    end
end
