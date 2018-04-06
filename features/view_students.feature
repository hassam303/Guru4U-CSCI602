Feature: View Students' Information
 
    As an ADVISOR
    So that I can keep track of new students
    I want to log the students' information

Background: Mentors and mentees are in database
  
 Given I am logged in as an Administrator
 And I am on the Dashboard page
  
Scenario:  view students 
  Then I should see "Dashboard"
  Then I should see all the students
  And I should see button "new_student_button"