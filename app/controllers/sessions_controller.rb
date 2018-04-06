class SessionsController < ApplicationController
  def new
    if logged_in?
      flash[:danger] = "You must log out before logging in."
      redirect_to root_path
    end
  end

  def create
    @user = User.find_by(email: params[:session][:email].downcase)
    if @user.nil?
      flash[:danger] = "Account does not exist."
       redirect_to login_path
    elsif @user.disabled
        flash[:danger] = "Login denied. Your account is disabled.  Please contact your administator."
        redirect_to root_path
    elsif @user.authenticate(params[:session][:password])
      if @user.activated?
        if @user.force_password_reset
          flash[:warning] = "You must reset your password to complete log in."
          redirect_to edit_password_reset_path(@user.id, email: @user.email)
        else
          log_in @user
          params[:session][:remember_me] == '1' ? remember(@user) : forget(@user)
          @user.successful_login
          redirect_back_or root_path
        end
      else
        flash[:warning] = "Account not activated. Check your email for the activation link."
        redirect_to root_path
      end
    else
      @user.failed_login_attempt
      if (login_attempts_remaining = @user.login_attempts_remaining) == 0
        flash[:danger] = ["Invalid email/password combination.","You have exceeded the maximim allowed login attempts.","Your account is now disabled."]
        @user.set_disabled true
        redirect_to root_path
      else
        flash[:danger] = "Invalid email/password combination."
        flash[:warning] = "You have #{login_attempts_remaining} login attempts remaining until your account is disabled."
        redirect_to login_path
      end
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to root_path
  end
end
