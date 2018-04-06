class AccountActivationsController < ApplicationController
  def edit
    if logged_in?
      flash[:danger] = "You cannot activate an account while logged in."
      redirect_to root_path
    else
      user = User.find_by(email: params[:email])
      if user && !user.activated? && user.authenticated?(:activation, params[:id])
        user.activate
        flash[:success] = "Account activated!"
        redirect_to login_path
      else
        flash[:danger] = "Invalid activation link."
        redirect_to root_path
      end
    end
  end
end
