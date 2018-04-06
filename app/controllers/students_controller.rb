class StudentsController < ApplicationController
  before_action :logged_in_user, only: [:index, :new, :create, :show, :edit, :update, :destroy]
  before_action :administrator_user, only: [:index, :new, :create, :show, :edit, :update, :destroy]

  def index
    #if we get here, must be a logged in administrator with current user set
    @grid = StudentsGrid.new(grid_params) do |scope|
      scope.page(params[:page])
    end
  end

  def new
     #if we get here, must be a logged in administrator with current user set
    @student = get_new_student_form_data()
  end
  
  def create
    #if we get here, must be a logged in administrator with current user set
    store_student_form_data(student_params)
    @student = Student.create(student_params)
    if !@student.errors.any?
      flash[:info] = "#{@student.name} was successfully created."
      forget_student_form_data
      response = User.create_user(
        { 
          name:  @student.name,
          email: @student.email,
          phone_number: @student.phone
        })
      if response[:message].nil?
          flash[:info] = [flash[:info],"User account succesfully created.","An activation email has been sent to #{@student.email}."]
      else
          flash[:warning] = "User account could not be created."
          flash[:danger] = response[:message]
      end
      redirect_to students_path
    else
      flash[:danger] = @student.errors.full_messages;
      redirect_back fallback_location: root_path
    end
  end
  
  def show
    #if we get here, must be a logged in administrator with current user set
  end
  
  def edit
    #if we get here, must be a logged in administrator with current user set
    @student = get_edit_student_form_data(Student.find_by(id: params[:id]))
   end
  
  def update
    #if we get here, must be a logged in administrator with current user set
    store_student_form_data(student_params)
    @student = Student.find_by(id: params[:id])
    if @student.nil?
      flash[:danger] = "Student with id #{params[:id]} does not exist"
      redirect_back fallback_location: root_path
    elsif @student.update_attributes(student_params)
      flash[:info] = "Student info updated."
      forget_student_form_data
      redirect_to students_path
    else
      flash[:danger] = @student.errors.full_messages
      redirect_back fallback_location: root_path
    end
 
  end
  
  def destroy
    #if we get here, must be a logged in administrator with current user set
  end
  
private
  
  def student_params
    transformed_params = Hash.new
    unprocessed_params = params.require(:student).permit(:name, :cwid, :email, :phone, :company, :role, :advisor, :mentor)
    unprocessed_params.each do |key,value|
      if key == "advisor"
        values = value.split('|')
        transformed_params['advisor'] = values[0]
        transformed_params['advisor_email'] = values[1]
      elsif key == 'mentor'
        values = value.split('|')
        transformed_params['mentor_id'] = values[1]
      else
        transformed_params[key] = value
      end
    end
    transformed_params
  end
  
  def grid_params
    params.fetch(:students_grid, {}).permit!
  end
  
  form_data_accessors 'Student'

end
