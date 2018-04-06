Feature: Request password reset as Advisor
 
  As an Advisor or a Mentor
  When I have forgotten my password
  I want to request my password to be reset

Background: an Advisor user and a Mentor user has been added to database
  
  Given I am on the home page
  
Scenario:  reset my password
  When I follow "log_in_link"
  Then I should be on the Login page
  And I follow "forgotten_password_link"
  Then I should be on the Forgotten Password page
  And I fill in "Email" with "guru4u602@gmail.com"
  And I press "submit_reset_request_button"
  Then I should be on the home page
  And I should see "Email sent with password reset instructions"
  Then I reset the password for "guru4u602@gmail.com"
  Then I wind up on the Reset Password page for "guru4u602@gmail.com"
  Then I fill in "Password" with "foobar"
  And I fill in "Password confirmation" with "foobar"
  And I press "update_password_button"
  Then I should be on the Dashboard page
  And I should see "Password has been reset."
 
Scenario:  reset my password but enter bad passwords
  When I follow "log_in_link"
  Then I should be on the Login page
  And I follow "forgotten_password_link"
  Then I should be on the Forgotten Password page
  And I fill in "Email" with "guru4u602@gmail.com"
  And I press "submit_reset_request_button"
  Then I should be on the home page
  And I should see "Email sent with password reset instructions"
  Then I reset the password for "guru4u602@gmail.com"
  Then I wind up on the Reset Password page for "guru4u602@gmail.com"
  Then I fill in "Password" with "foobar"
  And I fill in "Password confirmation" with "barfoo"
  And I press "update_password_button"
  Then I wind up on the Reset Password page for "guru4u602@gmail.com"
  And I should see "Password confirmation doesn't match Password"
  Then I fill in "Password" with "foo"
  And I fill in "Password confirmation" with "foo"
  And I press "update_password_button"
  Then I wind up on the Reset Password page for "guru4u602@gmail.com"
  And I should see "Password is too short (minimum is 6 characters)"
  Then I fill in "Password" with ""
  And I fill in "Password confirmation" with ""
  And I press "update_password_button"
  Then I wind up on the Reset Password page for "guru4u602@gmail.com"
  And I should see "Password can't be empty"
  
Scenario:  reset my password but enter bad email
  When I follow "log_in_link"
  Then I should be on the Login page
  And I follow "forgotten_password_link"
  Then I should be on the Forgotten Password page
  And I fill in "Email" with "totallybogus@email.com"
  And I press "submit_reset_request_button"
  Then I should be on the Forgotten Password page
  And I should see "Email address not found"
