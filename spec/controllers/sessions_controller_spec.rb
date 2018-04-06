require 'rails_helper'
include SessionsHelper

describe SessionsController do
    describe 'display login page happy path'  do
      it 'renders login page' do
        get :new
        expect(response).to render_template(:new)
      end
    end
    describe 'display login page sad path - user currently logged in'  do
      it 'redirects to root' do
        user = FactoryBot.create(:valid_administrative_user)
        log_in(user)
        expect(logged_in?).to be true
        get :new
        expect(response).to redirect_to(root_path)
        expect(flash[:danger]).to eq "You must log out before logging in."
      end
    end
    describe 'create login session for administrator user happy path ' do
      it 'redirects to Home page' do
        user = FactoryBot.create(:valid_administrative_user)
        post :create, params: {session: {email: user.email, password: user.password}}
        expect(logged_in?).to be true
        expect(response).to redirect_to(root_path)
      end
    end
    describe 'create login session for mentor user happy path '  do
      it 'redirects to Home page' do
        user = FactoryBot.create(:valid_user)
        post :create, params: {session: {email: user.email, password: user.password}}
        expect(logged_in?).to be true
        expect(response).to redirect_to(root_path)
      end
    end
    describe 'create login session for administrator user sad path - account does not exist'  do
      it 'redirects to login page' do
        expect(User).to receive(:find_by).and_return(nil)
        post :create, params: {session: {email: 'dummy', password: 'dummy'}}
        expect(response).to redirect_to(login_path)
        expect(flash[:danger]).to eq "Account does not exist."
        expect(logged_in?).to be false
      end
    end
    describe 'create login session for administrator user sad path - account is disabled'  do
      it 'redirects to home page' do
        user = FactoryBot.create(:valid_administrative_user,disabled: true)
        post :create, params: {session: {email: user.email, password: user.password}}
        expect(response).to redirect_to(root_path)
        expect(flash[:danger]).to eq "Login denied. Your account is disabled.  Please contact your administator."
        expect(logged_in?).to be false
      end
    end
    describe 'create login session for administrator user sad path - account does not authenticate, first time'  do
      it 'redirects to login page' do
        user = FactoryBot.create(:valid_administrative_user)
        post :create, params: {session: {email: user.email, password: 'bad_password'}}
        expect(response).to redirect_to(login_path)
        expect(flash[:danger]).to eq "Invalid email/password combination."
        expect(flash[:warning]).to eq "You have #{User.find(user.id).login_attempts_remaining} login attempts remaining until your account is disabled."
        expect(logged_in?).to be false
      end
    end
    describe 'create login session for administrator user sad path - account does not authenticate, exceeded allowed attempts'  do
      it 'account disabled and redirects to root page' do
        user = FactoryBot.create(:valid_administrative_user)
        expect_any_instance_of(User).to receive(:login_attempts_remaining).and_return(0)
        post :create, params: {session: {email: user.email, password: 'bad_password'}}
        expect(response).to redirect_to(root_path)
        expect(User.find(user.id).disabled).to be true
        expect(flash[:danger][0]).to eq "Invalid email/password combination."
        expect(flash[:danger][1]).to eq "You have exceeded the maximim allowed login attempts."
        expect(flash[:danger][2]).to eq "Your account is now disabled."
        expect(logged_in?).to be false
      end
    end
    describe 'create login session for administrator user sad path - account authenticates but not activated'  do
      it 'redirects to home page' do
        user = FactoryBot.create(:valid_administrative_user,activated: false)
        post :create, params: {session: {email: user.email, password: user.password}}
        expect(response).to redirect_to(root_path)
        expect(flash[:warning]).to eq "Account not activated. Check your email for the activation link."
        expect(logged_in?).to be false
      end
    end
    describe 'create login session for administrator user sad path - account authenticates and activated, but password needs resetting'  do
      it 'redirects to password reset page' do
        user = FactoryBot.create(:valid_administrative_user,force_password_reset: true)
        post :create, params: {session: {email: user.email, password: user.password}}
        expect(response).to redirect_to(edit_password_reset_path(user.id, email: user.email))
        expect(flash[:warning]).to eq "You must reset your password to complete log in."
        expect(logged_in?).to be false
      end
    end
    describe 'logout logged in user'  do
      it 'redirects to root path' do
        user = FactoryBot.create(:valid_administrative_user)
        log_in(user)
        expect(logged_in?).to be true
        delete :destroy
        expect(response).to redirect_to(root_path)
        expect(logged_in?).to be false
      end
    end
    describe 'logout user who is not logged in'  do
      it 'redirects to root path' do
        user = FactoryBot.create(:valid_administrative_user)
        expect(logged_in?).to be false
        delete :destroy
        expect(response).to redirect_to(root_path)
        expect(logged_in?).to be false
      end
    end
end