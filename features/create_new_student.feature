Feature: Enter new Mentor/Mentee
  
 As an ADVISOR
 So that I can keep track of new students
 I want to log the students' information
 
 Scenario:  successfully enter a new record
  Given I am logged in as an Administrator
  And I am on the Dashboard page
  When  I press "new_student_button"
  Then  I should be on the New Student page
  When I fill in "student_name_field" with "Anuja"
  And I fill in "student_cwid_field" with "99999999"
  And I fill in "student_email_field" with "anujagargate@gmail.com"
  And I fill in "student_phone_field" with "1234567890"
  And I choose "BRAVO" from "student_company_select"
  And I choose "MENTEE" from "student_role_select"
  And I choose "Michael P. Verdicchio" from "student_advisor_select"
  And I choose "Mike" from "student_mentor_select"
  And I press "Save Changes"
  Then I should be on the Dashboard page
  And I should see "Anuja was successfully created."
  