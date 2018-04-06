class ReportsController < ApplicationController
  include ReportsHelper
  before_action :logged_in_user, only: [:index, :new, :create, :show, :edit, :update, :destroy]
  before_action :correct_user,   only: [:edit, :new, :create, :destroy]
  before_action :correct_mentor_user, only: [:index]
  before_action :correct_mentee_for_mentor_user, only: [:show]
  before_action :correct_report_for_mentor_user, only: [:edit, :update,:destroy]
  before_action :correct_user_to_create_report, only: [:new, :create]

  def index
    #if we get here, must be a logged in correct user with current user set
    @student = Student.find_by(id: params[:id])
    unless @student.nil?
      @grid = StudentsGrid.new(grid_params) do |scope|
        scope.where("mentor_id = ?", @student.id).page(params[:page])
      end
    else
      nonexistent_student_error
    end
  end
  
  def new
    #if we get here, must be a logged in correct user with current user set
    @report = get_new_report_form_data
  end 
  
  def create
    #if we get here, must be a logged in correct user with current user set
    store_report_form_data(report_params)
    response = User.create_report(report_params)
    @report = response[:report]
    if response[:message].nil?
      flash[:info] = "Report for #{@report.mentee.name} added successfully!"
      forget_report_form_data
      redirect_to report_path(:id => Student.find_by(email: @report.mentee.email).id)
    else
      flash[:danger] = response[:message]
      redirect_back fallback_location: root_path
    end
  end
  
  def show
    #if we get here, must be a logged in correct user with current user set
    @student = Student.find_by(id: params[:id])
    unless @student.nil?
      @reports = @student.mentee_reports.order(created_at: :desc)
    else
      nonexistent_student_error
    end
  end
  
  def edit
   #if we get here, must be a logged in correct user with current user set
    @report = get_edit_report_form_data(Report.find_by(id: params[:id]))
    #byebug
  end
  
  def update
   #if we get here, must be a logged in correct user  with current user set
    @report = Report.find_by(id: params[:id])
    changes = false 
    
    if !@report.title.eql? params[:report][:title]
      @report.title = params[:report][:title]
      #changes = true
    end 
    
    if !@report.message.eql? params[:report][:message]
      @report.message = params[:report][:message]
      #changes = true
    end 
    
    if (@report.urgent <=> params[:report][:urgent]) != 0
      @report.urgent = params[:report][:urgent]
      changes = true 
    end 
    
    if changes == true 
      if @report.save 
        flash[:info] = "Report Successfully updated!"
        forget_report_form_data()
      else 
        flash[:danger] = "Report was NOT Successfully updated."
      end 
    else 
      flash[:danger ]= "No changes made!"
    
    end 
    
    redirect_to report_path(:id => Student.find_by(id: @report.mentee.id))
  end
  
  def destroy
   #if we get here, must be a logged in correct user with current user set
  end
  
private
  
  def report_params
    transformed_params = Hash.new
    params.require(:report).permit(:mentee, :title, :message, :urgent).each do |key,value|
      if key =="mentee"
        values = value.split('|')
        transformed_params['mentee_id'] = values[1]
      else
        transformed_params[key] = value
      end
    end
    transformed_params['mentor_id'] = get_current_user_student_id
    transformed_params
  end

  def grid_params
    params.fetch(:students_grid, {}).permit!
  end
  
  def nonexistent_student_error
    flash[:danger] = "Student does not exist."
    redirect_back fallback_location: root_path
  end

  # Create a report
  def User.create_report(report_params)
    report = Report.create(report_params)
    if !report.errors.any?
        {report: report, message: nil}
    else
      {report: report, message: report.errors.full_messages}
    end
  end
  
  form_data_accessors 'Report'
  
  def get_current_user_student_id
    return -current_user.id if current_user.admin?
    return 0 if (mentor = Student.find_by(email: current_user.email)).nil?
    mentor.id
  end
end
