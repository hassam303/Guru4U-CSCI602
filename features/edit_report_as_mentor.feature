Feature: Edit Report as a mentor
    As a mentor
    I want to edit a past report
    So that if I forget to write something, I can add it.
    
Background: A mentor has a mentee with reports
  
  Given I am logged in as a Mentor

Scenario: Edit report as a Mentor
  When I follow "mentee_report_3"
  Then I should see "Shelly Long's Reports"
  When I follow "edit_report_1"
  Then  I wind up on the Edit Mentor Report page for report "1", user "jsmith@gmail.com"
  And  I should see "Shelly is just the WORST!"
  And I fill in "report_message_area" with "Student showed up late"
  Then I press "report_submit_button"
  Then I wind up on the Mentee Reports page for Student "shelly@gmail.com"
  And I should see "Report Successfully updated!"
  
  
#Check line 11.  The number 3 was taken as the id from the dashboard.
#Her report link id might be different when logged in as a mentor
  
  