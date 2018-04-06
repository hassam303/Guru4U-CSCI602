class PasswordResetsController < ApplicationController
  before_action :get_user,   only: [:edit, :update]
  before_action :valid_user, only: [:edit, :update]
  before_action :check_expiration, only: [:edit, :update]    # Case (1)
 
  def new
  end

  def create
    @user = User.find_by(email: params[:password_reset][:email].downcase)
    if @user
      @user.create_reset_digest
      status = @user.send_email(:password_reset)
      if status.nil?
        flash[:info] = "Email sent with password reset instructions."
        redirect_to root_path
      else
        flash[:danger] = "Unable to send password reset email to #{@user.email}."
        @user.forget_reset_digest
        redirect_to new_password_reset_path
      end
    else
      flash[:danger] = "Email address not found."
      redirect_to new_password_reset_path
    end
  end

  def edit
  end
  
  def update
    if params[:user][:password].empty? # Case (3)
      @user.errors.add(:password, "can't be empty")
      flash[:danger] = @user.errors.full_messages
      redirect_to edit_password_reset_path(params[:id],email: @user.email)
    elsif @user.update_attributes(user_params) # Case (4)
      log_in @user
      flash[:success] = "Password has been reset."
      @user.forget_reset_digest
      @user.set_force_password_reset(false)
      redirect_to root_path
    else
      flash[:danger] = @user.errors.full_messages
      redirect_to edit_password_reset_path(params[:id],email: @user.email) # Case (2)
    end
  end

  private

    def user_params
      params.require(:user).permit(:password, :password_confirmation)
    end

    def get_user
      @user = User.find_by(email: params[:email])
    end

    # Confirms a valid user.
    def valid_user
      unless (@user && @user.activated? &&
              (@user.force_password_reset ||
              @user.authenticated?(:reset, params[:id])))
        redirect_to root_path
      end
    end
    
    # Checks expiration of reset token.
    def check_expiration
      if !@user.force_password_reset && @user.password_reset_expired?
        flash[:danger] = "Password reset has expired."
        @user.forget_reset_digest
        redirect_to new_password_reset_path
      end
    end
end
