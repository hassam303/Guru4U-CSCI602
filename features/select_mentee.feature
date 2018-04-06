Feature: Allow mentors to designate a mentee
  
  As a mentor 
  So that I can document my mentee meetings 
  I want to be able to select which mentee a report refers to


Background: I am logged in as a Mentor
  
  Given I am logged in as a Mentor
  
Scenario:  Select a mentee
  And I press "new_report_button"
  Then I should be on the New Mentor Report page
  And I should see "Mentee"
  And I should see the "report_mentee_select" select box
  And "report_mentee_select" should contain "Shelly"