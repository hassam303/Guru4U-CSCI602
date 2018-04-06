Feature: Edit Report as an Advisor
    As an advisor
    I want to edit a report
    So that I can document the report as seen/reached out to
    
Background: Mentors and mentees are in database
  
 Given I am logged in as an Administrator
 And I am on the Dashboard page
 
Scenario: edit report folllowing a mentees
  When I follow "mentee_report_3"
  Then I wind up on the Mentee Reports page for Student "shelly@gmail.com"
  And I should see "Shelly Long's Reports"
  When I follow "edit_report_1"
  Then  I wind up on the Edit Mentor Report page for report "1", user "guru4u602@gmail.com"
  And  I should see "Shelly is just the WORST!"
  And I fill in "report_message_area" with "Student was contacted in class"
  Then I press "report_submit_button"
  Then I wind up on the Mentee Reports page for Student "shelly@gmail.com"
  And I should see "Report Successfully updated!"
  
Scenario: edit report following a Mentor
  When I follow "mentor_reports_1"
  Then I wind up on the Mentee List page for Mentor "jsmith@gmail.com"
  And I should see "Johnny Smith's Mentees"
  Then I follow "mentee_report_3"
  And I wind up on the Mentee Reports page for Student "shelly@gmail.com"
  And I should see "Shelly Long's Reports"
  
#Second scenario is finished in the first scenario from line 14 and after








  
    
    
    