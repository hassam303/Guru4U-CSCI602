Feature: General Login tests
 
  As a User
  So that I use Guru4u
  I want to login

Background: an Advisor user and a Mentor user has been added to database
  
  Given  I am on the home page
  
Scenario: I enter a bad password
  When I follow "log_in_link"
  Then I should be on the Login page
  And I fill in "Email" with "guru4u602@gmail.com"
  And I fill in "Password" with "notreally"
  And I press "log_in_button"
  Then I should be on the Login page
  And I should see "Invalid email/password combination"
  
@check_remember_me
Scenario: I check remember me as an Advisor
  When I follow "log_in_link"
  Then I should be on the Login page
  And I fill in "Email" with "guru4u602@gmail.com"
  And I check "remember_me_checkbox"
  And I fill in "Password" with "foobar"
  And I press "log_in_button"
  Then I should be on the Dashboard page
  And  I follow "log_out_link"
  Then I should be on the home page
  Then I go to the Manage Users page
  And I should be on the Login page
  And I should see "Please log in."
