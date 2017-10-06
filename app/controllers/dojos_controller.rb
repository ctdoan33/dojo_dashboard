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
      render "new.html"
    end
  end

  def edit
    @dojo = Dojo.find(params[:id])
  end

  def update
    @dojo = Dojo.find(params[:id])
    if @dojo.update(dojo_params)
      redirect_to "/dojos"
    else
      render "edit.html"
    end
  end

  def show
    @dojo = Dojo.find(params[:id])
    @students = Student.where(dojo: @dojo)
  end

  def destroy
    Dojo.find(params[:id]).destroy
    redirect_to "/dojos"
  end

  private
    def dojo_params
      params.require(:dojo).permit(:branch, :street, :city, :state)
    end
end
