class StudentsController < ApplicationController
  def index
    @dojo = Dojo.find(params[:dojo_id])
    @students = Student.where(dojo: @dojo)
    render "dojos/show.html"
  end

  def new
    @dojo = Dojo.find(params[:dojo_id])
    @dojos = Dojo.all
    @student = Student.new
  end

  def create
    @dojo = Dojo.find(params[:dojo_id])
    @dojos = Dojo.all
    @student = Student.new(student_params)
    @student.dojo = Dojo.find(params[:dojo].to_i)
    if @student.save
      redirect_to "/dojos/#{params[:dojo_id]}/students"
    else
      render "new.html"
    end
  end

  def show
    @dojo = Dojo.find(params[:dojo_id])
    @student = Student.find(params[:id])
    @cohorts = Student.where(dojo: @dojo).where.not(id: params[:id])
    # cohort is currently all other students at dojo
  end

  def edit
    @dojo = Dojo.find(params[:dojo_id])
    @dojos = Dojo.all
    @student = Student.find(params[:id])
  end

  def update
    @dojo = Dojo.find(params[:dojo_id])
    @dojos = Dojo.all
    @student = Student.find(params[:id])
    if @student.update(student_params)
      @student.update(dojo: Dojo.find(params[:dojo].to_i))
      redirect_to "/dojos/#{params[:dojo]}/students"
    else
      render "new.html"
    end
  end

  def destroy
    Student.find(params[:id]).destroy
    redirect_to "/dojos/#{params[:dojo_id]}/students"
  end

  private
    def student_params
      params.require(:student).permit(:first_name, :last_name, :email)
    end
end
