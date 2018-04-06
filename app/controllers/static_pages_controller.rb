class StaticPagesController < ApplicationController
  def home
    if logged_in?
      if current_user.administrator?
         redirect_to students_path and return
      end

      if !(student = Student.find_by(email: current_user.email)).nil?
        if (student.role == Student::MENTOR)
          redirect_to reports_path(id: student.id)
        else
          flash[:danger] = "Only an administrator or mentor can use this system. Please contact your advisor."
        end
      else
        flash[:danger] = "No student record exists for #{current_user.name}.  Please contact your advisor."
      end
    end
  end

  def help
  end
  
  def about
  end
  
  def contact
  end
end
