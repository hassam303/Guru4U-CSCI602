Feature: Allow new reports to be created 
  
  As a mentor 
  So that I can document my mentee meetings 
  I want to be able to create new reports


Background: I am logged in as a Mentor 
  
  Given I am logged in as a Mentor
  
Scenario:  Properly set-up page
  And I press "new_report_button"
  Then I should be on the New Mentor Report page
  And I should see "Message"
  And I should see "Title"
  And I should see "Urgent"
