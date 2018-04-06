class UsersController < ApplicationController
  before_action :logged_in_user, only: [:index, :new, :create, :show, :edit, :update, :destroy]
  before_action :correct_user,   only: [:show, :edit, :update]
  before_action :administrator_user, only: [:index, :new, :create, :destroy]
 
  def index
    #if we get here, must be a logged in administrator with current_user set
    
    @grid = UsersGrid.new(grid_params) do |scope|
      scope.page(params[:page])
    end
  end

  def new
    #if we get here, must be a logged in administrator with current_user set
    @user = get_new_user_form_data
  end
  
  def create
    #if we get here, must be a logged in administrator with current_user set
    store_user_form_data(user_params)
    response = User.create_user(user_params)
    @user = response[:user]
    if response[:message].nil?
        flash[:info] = ["User account successfully created.","An account activation email has been sent to #{@user.email}."]
        flash[:warning] = "Password was defaulted to the email address, which must be changed at initial login." if response[:password_defaulted]
        forget_user_form_data
        redirect_to users_path
    else
        flash[:danger] = response[:message]
        redirect_back fallback_location: root_path
    end
  end
  
  def show
    #if we get here, must be the logged in correct_user with current user and @user set
  end
  
  def edit
    #if we get here, must be the logged in correct_user with current user and @user set
    @user = get_edit_user_form_data(@user)
  end
  
  def update
    destroy and return unless params[:delete].nil?
    
    #if we get here, must be the logged in correct_user with current user and @user set
    store_user_form_data(user_params)
    filtered_params = 
      user_params.tap do |h|
        h[:consecutive_failed_login_attempts] = 0 if h[:disabled] == "0"
      end.reject do |k,v| 
        ([:password,:password_confirmation].include? k && v.blank?) || #ignore empty password and password_confirmation fields
        (k == :email && v == @user.email) #ignore email address if it did not change
      end
    if @user.update_attributes(filtered_params)
      flash[:info] = "User settings updated."
      forget_user_form_data
      if current_user.admin
        redirect_to users_path
      else
        redirect_to @user
      end
    else
      flash[:danger] = @user.errors.full_messages
      redirect_back fallback_location: root_path
    end
  end  
  
  def destroy
    #if we get here, must be a logged in administrator with current_user set
    @user = User.find_by(id: params[:id])
    unless @user.nil?
      unless current_user?(@user)
        @user.destroy
        flash[:info] = "User deleted."
        forget_user_form_data
      else
        flash[:warning] = "You cannot delete yourself."
      end
      redirect_to users_path
    else
      nonexistent_user_error
    end
  end

private

  def user_params
    params.require(:user).permit(:name, :email, :phone_number, :password,
                                 :password_confirmation,:admin,:disabled,:force_password_reset)
  end
    
  def grid_params
    params.fetch(:users_grid, {}).permit!
  end
  
  form_data_accessors 'User'
  
end
