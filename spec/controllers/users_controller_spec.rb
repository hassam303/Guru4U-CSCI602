require 'rails_helper'
include SessionsHelper

describe UsersController do
    describe 'display manage users page happy path'  do
      it 'renders manage users page' do
        user = FactoryBot.create(:valid_administrative_user)
        log_in(user)
        get :index
        expect(response).to render_template(:index)
      end
    end
    describe 'display manage users page sad path - not logged in'  do
      it 'redirects to login page' do
        get :index
        expect(response).to redirect_to(login_path)
        expect(flash[:danger]).to eq "Please log in."
      end
    end
    describe 'display manage users page sad path - non-administrator logged in'  do
      it 'redirects to home page' do
        user = FactoryBot.create(:valid_user)
        log_in(user)
        get :index
        expect(response).to redirect_to(root_path)
        expect(flash[:danger]).to eq "Only an administrator can do that."
      end
    end
    #---------------
    describe 'display user profile page happy path'  do
      it 'renders users profile page' do
        user = FactoryBot.create(:valid_user)
        log_in(user)
        get :show, params: {id: user.id}
        expect(response).to render_template(:show)
      end
    end
    describe 'display user profile page happy path - other users is administrator'  do
      it 'renders users profile page' do
        user = FactoryBot.create(:valid_user)
        admin_user = FactoryBot.create(:valid_administrative_user)
        log_in(admin_user)
        get :show, params: {id: user.id}
        expect(response).to render_template(:show)
      end
    end
    describe 'display user profile page sad path - not logged in'  do
      it 'redirects to login page' do
        user = FactoryBot.create(:valid_user)
        get :show, params: {id: user.id}
        expect(response).to redirect_to(login_path)
        expect(flash[:danger]).to eq "Please log in."
      end
    end
    describe 'display user profile page sad path - wrong user'  do
      it 'redirects to home page' do
        user = FactoryBot.create(:valid_user)
        other_user = FactoryBot.create(:valid_user,email: "other_"+user.email)
        log_in(user)
        get :show, params: {id: other_user.id}
        expect(response).to redirect_to(root_path)
        expect(flash[:danger]).to eq "Only the account owner or an adminstrator to do that."
      end
    end
    #---------------
    describe 'display new user page happy path'  do
      it 'renders new user page' do
        admin_user = FactoryBot.create(:valid_administrative_user)
        log_in(admin_user)
        get :new
        expect(response).to render_template(:new)
      end
    end
    describe 'display new user page sad path - user is not an administrator'  do
      it 'redirects to home page' do
        user = FactoryBot.create(:valid_user)
        log_in(user)
        get :new
        expect(response).to redirect_to(root_path)
        expect(flash[:danger]).to eq "Only an administrator can do that."
      end
    end
    describe 'display new user page sad path - not logged in'  do
      it 'redirects to login page' do
        get :new
        expect(response).to redirect_to(login_path)
        expect(flash[:danger]).to eq "Please log in."
      end
    end
    #---------------
    describe 'create new user happy path'  do
      it 'redirects to manage users page' do
        admin_user = FactoryBot.create(:valid_administrative_user)
        log_in(admin_user)
        post :create, params: {user: FactoryBot.attributes_for(:valid_user)}
        expect(response).to redirect_to(users_path)
        expect(flash[:info][0]).to eq "User account successfully created."
        expect(flash[:info][1]).to eq "An account activation email has been sent to #{assigns(:user).email}."
       end
    end
    describe 'create new user sad path - user cannot be created' do
      it 'redirects to new user page' do
        admin_user = FactoryBot.create(:valid_administrative_user)
        log_in(admin_user)
        expect(User).to receive(:create_user).and_return({user: nil,message: "Something Failed"})
        request.env['HTTP_REFERER'] = new_user_path
        post :create, params: {user: FactoryBot.attributes_for(:valid_user)}
        expect(response).to redirect_to(new_user_path)
        expect(flash[:danger]).to eq "Something Failed"
       end
    end
    describe 'create new user sad path - not logged in'  do
      it 'redirects to login page' do
        post :create, params: {user: FactoryBot.attributes_for(:valid_user)}
        expect(response).to redirect_to(login_path)
        expect(flash[:danger]).to eq "Please log in."
      end
    end
    describe 'create new user sad path - user is not an administrator'  do
      it 'redirects to home page' do
        user = FactoryBot.create(:valid_user)
        log_in(user)
        post :create, params: {user: FactoryBot.attributes_for(:valid_user)}
        expect(response).to redirect_to(root_path)
        expect(flash[:danger]).to eq "Only an administrator can do that."
      end
    end
    #---------------
    describe 'edit user page happy path'  do
      it 'renders edit users page' do
        user = FactoryBot.create(:valid_user)
        log_in(user)
        get :edit, params: {id: user.id}
        expect(response).to render_template(:edit)
      end
    end
    describe 'edit user page happy path - other user is administrator'  do
      it 'renders edit users page' do
        user = FactoryBot.create(:valid_user)
        admin_user = FactoryBot.create(:valid_administrative_user)
        log_in(admin_user)
        get :edit, params: {id: user.id}
        expect(response).to render_template(:edit)
      end
    end
    describe 'edit user page sad path - not logged in'  do
      it 'redirects to login page' do
        user = FactoryBot.create(:valid_user)
        get :edit, params: {id: user.id}
        expect(response).to redirect_to(login_path)
        expect(flash[:danger]).to eq "Please log in."
      end
    end
    describe 'edit user page sad path - wrong user'  do
      it 'redirects to home page' do
        user = FactoryBot.create(:valid_user)
        other_user = FactoryBot.create(:valid_user,email: "other_"+user.email)
        log_in(user)
        get :edit, params: {id: other_user.id}
        expect(response).to redirect_to(root_path)
        expect(flash[:danger]).to eq "Only the account owner or an adminstrator to do that."
      end
    end
    #---------------
    describe 'update user happy path - administrator is logged in'  do
      it 'redirects to manage users page' do
        admin_user = FactoryBot.create(:valid_administrative_user)
        user =  FactoryBot.create(:valid_user)
        log_in(admin_user)
        put :update, params: {id: user.id, user: FactoryBot.attributes_for(:valid_user)}
        expect(response).to redirect_to(users_path)
        expect(flash[:info]).to eq "User settings updated."
       end
    end
    describe 'update user happy path - same user is logged in'  do
      it 'redirects to user profile page' do
        user =  FactoryBot.create(:valid_user)
        log_in(user)
        put :update, params: {id: user.id, user: FactoryBot.attributes_for(:valid_user)}
        expect(response).to redirect_to(user_path(user.id))
        expect(flash[:info]).to eq "User settings updated."
       end
    end
    describe 'update user sad path - not logged in'  do
      it 'redirects to login page' do
        user = FactoryBot.create(:valid_user)
        put :update, params: {id: user.id, user: FactoryBot.attributes_for(:valid_user)}
        expect(response).to redirect_to(login_path)
        expect(flash[:danger]).to eq "Please log in."
      end
    end
    describe 'update user sad path - wrong user'  do
      it 'redirects to home page' do
        user = FactoryBot.create(:valid_user)
        other_user = FactoryBot.create(:valid_user,email: "other_"+user.email)
        log_in(user)
        put :update, params: {id: other_user.id, user: FactoryBot.attributes_for(:valid_user,email: "other_"+user.email)}
        expect(response).to redirect_to(root_path)
        expect(flash[:danger]).to eq "Only the account owner or an adminstrator to do that."
      end
    end
    describe 'update user sad path - user does not exist'  do
      it 'redirects to home page' do
        user = FactoryBot.create(:valid_user)
        log_in(user)
        put :update, params: {id: user.id*10, user: FactoryBot.attributes_for(:valid_user)}
        expect(response).to redirect_to(root_path)
        expect(flash[:danger]).to eq "User does not exist."
      end
    end
    describe 'update user sad path - bad update parameters'  do
      it 'redirects to edit user page' do
        user = FactoryBot.create(:valid_user)
        log_in(user)
        request.env['HTTP_REFERER'] = edit_user_path(user.id)
        put :update, params: {id: user.id, user: FactoryBot.attributes_for(:valid_user,password: "short")}
        expect(response).to redirect_to(edit_user_path(user.id))
        expect(flash[:danger][0]).to eq "Password confirmation doesn't match Password"
        expect(flash[:danger][1]).to eq "Password is too short (minimum is 6 characters)"
      end
    end
    #---------------
    describe 'delete user happy path'  do
      it 'redirects to manage users page' do
        admin_user = FactoryBot.create(:valid_administrative_user)
        user =  FactoryBot.create(:valid_user)
        log_in(admin_user)
        delete :destroy, params:  {id: user.id}
        expect(response).to redirect_to(users_path)
        expect(flash[:info]).to eq  "User deleted."
       end
    end
    describe 'delete user sad path - not logged in'  do
      it 'redirects to login page' do
        user = FactoryBot.create(:valid_user)
        delete :destroy, params:  {id: user.id}
        expect(response).to redirect_to(login_path)
        expect(flash[:danger]).to eq "Please log in."
      end
    end
    describe 'delete user sad path - user is not an administrator'  do
      it 'redirects to home page' do
        user = FactoryBot.create(:valid_user)
        log_in(user)
        delete :destroy, params:  {id: user.id}
        expect(response).to redirect_to(root_path)
        expect(flash[:danger]).to eq "Only an administrator can do that."
      end
    end
    describe 'delete user sad path - user does not exist'  do
      it 'redirects to home page' do
        admin_user = FactoryBot.create(:valid_administrative_user)
        user =  FactoryBot.create(:valid_user)
        log_in(admin_user)
        delete :destroy, params: {id: user.id*10}
        expect(response).to redirect_to(root_path)
        expect(flash[:danger]).to eq "User does not exist."
      end
    end
    describe 'delete user sad path - user is logged in user'  do
      it 'redirects to manage users page' do
        admin_user = FactoryBot.create(:valid_administrative_user)
        user =  FactoryBot.create(:valid_user)
        log_in(admin_user)
        delete :destroy, params: {id: admin_user.id}
        expect(response).to redirect_to(users_path)
        expect(flash[:warning]).to eq "You cannot delete yourself."
      end
    end
end