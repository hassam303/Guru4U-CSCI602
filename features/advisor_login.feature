Feature: Login as an Advisor
 
  As an Advisor
  So that I can manage my students
  I want to login and see my dashboard

Background: an Advisor user and a Mentor user has been added to database
  
  Given  I am on the home page
  When I follow "log_in_link"
  Then I should be on the Login page
  And I fill in "Email" with "guru4u602@gmail.com"
  And I fill in "Password" with "foobar"
  And I press "log_in_button"
  Then I should be on the Dashboard page
  
Scenario:  look at my profile
  When I follow "account_link"
  And  I follow "profile_link"
  Then I should be on the Profile page for "guru4u602@gmail.com"
  
Scenario:  look at my settings
  When I follow "account_link"
  And  I follow "settings_link"
  Then I should be on the Settings page for "guru4u602@gmail.com"

Scenario:  change my settings
  When I follow "account_link"
  And  I follow "settings_link"
  Then I should be on the Settings page for "guru4u602@gmail.com"
  And I expect "name_field" to contain "Guru4u Administrator"  
  And I expect "email_field" to contain "guru4u602@gmail.com"
  And I expect "telephone_field" to contain "(843) 555-0000"
  And I expect "password_field" to be empty
  And I expect "password_confirmation_field" to be empty
  And I press "update_user_button"
  Then I should be on the Manage Users page
  And I should see "User settings updated."

Scenario: home link takes me to Dashboard
  When I follow "help_link"
  Then I should be on the Help page
  When I follow "home_link"
  Then I should be on the Dashboard page
  
Scenario: log out takes me to home page
  When I follow "account_link"
  And  I follow "log_out_link"
  Then I should be on the home page
  
Scenario: create a new user with specified password
  When I go to the New User page
  And I fill in "name_field" with "Test User"
  And I fill in "email_field" with "testuser@test.com"
  And I fill in "telephone_field" with "1234567890"
  And I fill in "password_field" with "testuser"
  And I fill in "password_confirmation_field" with "testuser"
  And I press "create_account_button"
  Then I should be on the Manage Users page
  And I should see "An account activation email has been sent to testuser@test.com"
  Then I activate the account for "testuser@test.com"
  Then I activate the account for "testuser@test.com"
  Then I should be on the Dashboard page
  And I should see "You cannot activate an account while logged in."
  Then I follow "log_out_link"
  And I should be on the home page
  Then I activate the account for "testuser@test.com"
  Then I should be on the Login page
  And I should see "Account activated!"
  Then I fill in "Email" with "testuser@test.com"
  And I fill in "Password" with "testuser"
  And I press "log_in_button"
  Then I should be on the home page
  And I should see "No student record exists for Test User."

Scenario: create a new user with default password
  When I go to the New User page
  And I fill in "name_field" with "Test User"
  And I fill in "email_field" with "testuser@test.com"
  And I fill in "telephone_field" with "1234567890"
  And I press "create_account_button"
  Then I should be on the Manage Users page
  And I should see "An account activation email has been sent to testuser@test.com"
  Then I follow "log_out_link"
  And I should be on the home page
  Then I activate the account for "testuser@test.com"
  Then I should be on the Login page
  And I should see "Account activated!"
  Then I fill in "Email" with "testuser@test.com"
  And I fill in "Password" with "testuser@test.com"
  And I press "log_in_button"
  Then I wind up on the Reset Password page for "testuser@test.com"
  Then I fill in "Password" with "testuser"
  And I fill in "Password confirmation" with "testuser"
  And I press "update_password_button"
  Then I should be on the home page
  And I should see "Password has been reset."
  And I should see "No student record exists for Test User."

Scenario: create a new user and try to log in to new user before activation
  When I go to the New User page
  And I fill in "name_field" with "Test User"
  And I fill in "email_field" with "testuser@test.com"
  And I fill in "telephone_field" with "1234567890"
  And I fill in "password_field" with "testuser"
  And I fill in "password_confirmation_field" with "testuser"
  And I press "create_account_button"
  Then I should be on the Manage Users page
  And I should see "An account activation email has been sent to testuser@test.com"
  Then I go to the Login page
  Then I should be on the Dashboard page
  And I should see "You must log out before logging in."
  Then I follow "log_out_link"
  And I am on the home page
  Then I go to the Login page
  And I fill in "Email" with "testuser@test.com"
  And I fill in "Password" with "testuser"
  And I press "log_in_button"
  Then I should be on the home page
  And I should see "Account not activated."

Scenario: edit a user to disable their account and try to log in
  When I go to the Edit User page for "example-1@gmail.com"
  And I check "disable_account_checkbox"
  And I press "update_user_button"
  Then I should be on the Manage Users page
  And I follow "log_out_link"
  And I go to the Login page
  And I fill in "Email" with "example-1@gmail.com"
  And I fill in "Password" with "password"
  And I press "log_in_button"
  Then I should be on the home page
  And I should see "Login denied. Your account is disabled.  Please contact your administator."
  
  
@javascript
Scenario: delete a user
  When I go to the Edit User page for "example-1@gmail.com"
  Then I delete the account with "delete_user_button"
  Then I should be on the Manage Users page
  And I should see "User deleted."
  And I should not find the account for "example-1@gmail.com"
  
  