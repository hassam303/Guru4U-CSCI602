module SessionsHelper
  # Logs in the given user.
  def log_in(user)
    session[:user_id] = user.id
  end
  
  # Remembers a user in a persistent session.
  def remember(user)
    user.remember
    cookies.permanent.signed[:user_id] = user.id
    cookies.permanent[:remember_token] = user.remember_token
  end
  
  # Returns true if the given user is the current user.
  def current_user?(user)
    user == current_user
  end

  # Returns the current logged-in user (if any).
  def current_user
    if (user_id = session[:user_id])
      @current_user ||= User.find_by(id: user_id)
    elsif (user_id = cookies.signed[:user_id])
      user = User.find_by(id: user_id)
      if user && user.authenticated?(:remember, cookies[:remember_token])
        log_in user
        @current_user = user
      end
    end
  end
  
   # Returns true if the user is logged in, false otherwise.
  def logged_in?
    !current_user.nil?
  end
 
  # Forgets a persistent session.
  def forget(user)
    user.forget
    cookies.delete(:user_id)
    cookies.delete(:remember_token)
  end
  
  # Logs out the current user.
  def log_out
    forget(current_user)
    session.delete(:user_id)
    @current_user = nil
  end
  
  # Redirects to stored location (or to the default).
  def redirect_back_or(default)
    redirect_to(session[:forwarding_url] || default)
    session.delete(:forwarding_url)
  end

  # Stores the URL trying to be accessed.
  def store_location
    session[:forwarding_url] = request.original_url if request.get?
  end
  
  def nonexistent_user_error
      flash[:danger] = "User does not exist."
      redirect_to(root_path)
  end

  # Confirms a logged-in user.
  def logged_in_user
    unless logged_in?
      store_location
      flash[:danger] = "Please log in."
      redirect_to login_path
    end
  end

  # Confirms the correct user.
  def correct_user
    user_id = params[:user_id] || params[:id] || session[:user_id]
    @user = User.find_by(id: user_id)
    unless @user.nil?
      unless current_user?(@user) || current_user.administrator?
        flash[:danger] = "Only the account owner or an adminstrator to do that."
        redirect_to(root_path)
      end
    else
      nonexistent_user_error
    end
  end
  
  # Confirms an administrator user.
  def administrator_user
    unless current_user.administrator?
      flash[:danger] = "Only an administrator can do that."
      redirect_to(root_path)
    end
  end

  # Stores form data that was entered incorrectly
  def store_form_data(type,data)
    session[type] = data
  end
  
  # Delete stored form data that was entered incorrectly
  def forget_form_data(type)
    session.delete(type)
  end
  
  # Get stored form data
  
  def get_form_data(my_class,type)
    my_class.new(session[type]) unless session[type].nil?
  end
  
  def get_new_form_data(my_class,type)
      get_form_data(my_class,type) || my_class.new
  end
  
  def get_edit_form_data(my_class,type,default_form_data)
    #use saved form data for edit template if record being edited is the same
    #otherwise use new my_class data for edit template

    form_data = get_form_data(my_class,type)
    
    unless form_data.nil? || form_data.id.nil? || form_data.id != default_form_data.id
      form_data
    else
      default_form_data
    end
  end
  
end
