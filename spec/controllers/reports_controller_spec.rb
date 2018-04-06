require 'rails_helper'
include SessionsHelper

describe ReportsController do
    describe 'edit report as a mentor- happy path' do
        it 'edits a report succesfully' do
            mentor_student = FactoryBot.create(:mentor_student)
            mentee_student = FactoryBot.create(:mentee_student,mentor_id: mentor_student.id)
            report = FactoryBot.create(:student_report,mentor_id: mentor_student.id,mentee_id: mentee_student.id)
            mentor_user = FactoryBot.create(:mentor_user)
            log_in(mentor_user)
            get :edit, params: {id: report.id,user_id: mentor_user.id}
            expect(response).to render_template(:edit)
        end
    end

    
    describe 'edit report as an advisor - happy path' do
        it 'edits a report succesfully' do
            mentor_student = FactoryBot.create(:mentor_student)
            mentee_student = FactoryBot.create(:mentee_student,mentor_id: mentor_student.id)
            report = FactoryBot.create(:student_report,mentor_id: mentor_student.id,mentee_id: mentee_student.id)
            advisor_user = FactoryBot.create(:valid_administrative_user)
            log_in(advisor_user)
            get :edit, params: {id: report.id,user_id: advisor_user.id}
            expect(response).to render_template(:edit)
        end
    end
    
    describe 'edit report- sad path (wrong user)' do
        it 'redirects to home page' do
            user = FactoryBot.create(:valid_user)
            user_mentor = FactoryBot.create(:mentor_student)
            user_mentee = FactoryBot.create(:mentee_student,mentor_id:user_mentor.id)
            report = FactoryBot.create(:valid_report, mentee_id:user_mentee.id,mentor_id:user_mentor.id)
            log_in(user)
            get :edit, params: {id: user_mentor.id,reportid: report.id}
            expect(response).to redirect_to(root_path)
            expect(flash[:danger]).to eq "Only the account owner or an adminstrator to do that."
      end
    end
    
    describe 'edit report - sad path (not logged in)' do
        it 'redirects to login page' do
            user = FactoryBot.create(:valid_user)
            user_mentor = FactoryBot.create(:mentor_student)
            user_mentee = FactoryBot.create(:mentee_student,mentor_id:user_mentor.id)
            report = FactoryBot.create(:valid_report, mentee_id:user_mentee.id)
            get :edit, params: {id: user.id,reportid: report.id}
            expect(response).to redirect_to(login_path)
            expect(flash[:danger]).to eq "Please log in."
      end
    end
end