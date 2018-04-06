Feature: Edit a Student

    As an adivsor
    I want to edit a student
    So that I can update students' information.    

Scenario: Edit Student Record

Given I am logged in as an Administrator
And I am on the Dashboard page
When I follow "edit_student_1"
Then I should be on the Edit Student page for "Johnny Smith"
And I expect "student_name_field" to contain "Johnny Smith"
And I expect "student_email_field" to contain "jsmith@gmail.com"
And I expect "student_phone_field" to contain "(843) 555-0001"
And "student_company_select" should contain "ALPHA"
And "student_role_select" should contain "MENTOR"
And "student_advisor_select" should contain "Michael P. Verdicchio"
And "student_mentor_select" should contain "UNASSIGNED"
And I fill in "student_name_field" with "Nik"
And I press "edit_button"
Then I should be on the Dashboard page
And I should see "Student info updated"
