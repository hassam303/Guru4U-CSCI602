require 'rails_helper'
include SessionsHelper

describe StudentsController do
    describe 'create a new student happy path'  do
        it 'creates a new student and new student account successfully' do
          user = FactoryBot.create(:valid_administrative_user)
          log_in(user)
          post :create, params: {student: FactoryBot.attributes_for(:student)}
          expect(response).to redirect_to(students_path)
          expect(flash[:info][0]).to eq "#{assigns(:student).name} was successfully created."
          expect(flash[:info][1]).to eq "User account succesfully created."
          expect(flash[:info][2]).to eq "An activation email has been sent to #{assigns(:student).email}."
        end
        
        it 'creates a new student sad path - mocks being unable to create account' do
          user = FactoryBot.create(:valid_administrative_user)
          log_in(user)
          expect(User).to receive(:create_user).and_return({user: nil,message: "Something Failed"})
          post :create, params: {student: FactoryBot.attributes_for(:student)}
          expect(response).to redirect_to(students_path)
          expect(flash[:danger]).to eq "Something Failed"
        end
    end
    
    describe 'edit student-happy path' do
      it 'renders edit student page' do
        advisor_user = FactoryBot.create(:valid_administrative_user)
        mentor_student = FactoryBot.create(:mentor_student)
        mentee_student= FactoryBot.create(:mentee_student,mentor_id: mentor_student.id)
        log_in(advisor_user)
        get :edit, params: {id: mentee_student.name,user_id: advisor_user.id}
        expect(response).to render_template(:edit)
      end
    end
    describe 'edit student-sad path' do
      it 'redirects to login page' do
        advisor_user = FactoryBot.create(:valid_administrative_user)
        mentor_student = FactoryBot.create(:mentor_student)
        mentee_student= FactoryBot.create(:mentee_student,mentor_id: mentor_student.id)
        get :edit, params: {id: mentee_student.name,user_id: advisor_user.id}
        expect(response).to redirect_to(login_path)
        expect(flash[:danger]).to eq "Please log in."
      
      end
    end
end