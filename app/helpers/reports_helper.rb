module ReportsHelper
  def get_current_user_student
    Student.find_by(email: current_user.email)
  end
  
  def correct_mentor_user
    return if current_user.administrator?
    mentor_id = params[:id].to_i
    mentor_student = Student.find_by(id: mentor_id)
    unless mentor_student.nil?
      if mentor_student.role == Student::MENTOR
        current_user_student = get_current_user_student
        unless current_user_student.nil?
          if current_user_student.role == Student::MENTOR
            return if current_user_student.id == mentor_id
            flash[:danger] = "A mentor can only view their own mentees"
          else
            flash[:danger] = "The current user is not a mentor"
          end
        else
          flash[:danger] = "The current user's email does not match any student. Please contact the administrator"
        end
      else
        flash[:danger] = "The specified student is not a mentor"
      end
    else
      flash[:danger] = "The specified student does not exist"
    end
    redirect_back fallback_location: root_path
  end
  
  def correct_mentee_for_mentor_user
    return if current_user.administrator?
    mentee_id = params[:id].to_i
    mentee_student = Student.find_by(id: mentee_id)
    unless mentee_student.nil?
      if mentee_student.role == Student::MENTEE
        current_user_student = get_current_user_student
        unless current_user_student.nil?
          if current_user_student.role == Student::MENTOR
            return if mentee_student.mentor_id == current_user_student.id
            flash[:danger] = "A mentor can only view reports for their own mentees"
          else
            flash[:danger] = "The current user is not a mentor"
          end
        else
          flash[:danger] = "The current user's email does not match any student. Please contact the administrator"
        end
      else
        flash[:danger] = "The specified student is not a mentee"
      end
    else
      flash[:danger] = "The specified student does not exist"
    end
    redirect_back fallback_location: root_path
  end
  
  def correct_report_for_mentor_user
    return if current_user.administrator?
    report_id = params[:id].to_i
    report = Report.find_by(id: report_id)
    unless report.nil?
      current_user_student = get_current_user_student
      unless current_user_student.nil?
        if current_user_student.role == Student::MENTOR
          return if report.mentor_id == current_user_student.id
          flash[:danger] = "A mentor can only modify reports for their own mentees"
        else
          flash[:danger] = "The current user is not a mentor"
        end
      else
        flash[:danger] = "The current user's email does not match any student. Please contact the administrator"
      end
    else
      flash[:danger] = "The specified report does not exist"
    end
    redirect_back fallback_location: root_path
  end
  
  def correct_user_to_create_report
    unless current_user.administrator?
      current_user_student = get_current_user_student
      unless current_user_student.nil?
        return current_user_student.role == Student::MENTOR
        flash[:danger] = "The current user is not a mentor"
      else
        flash[:danger] = "The current user's email does not match any student. Please contact the administrator"
      end
      
    else
      flash[:warning] = "Administrators can only view and edit existing reports at this time"
    end
    redirect_back fallback_location: root_path
  end
end
