Feature: Sort students by name, advisor, company, role
    As an advisor
    I want to sort students
    So I can view them more easily
    
Background: Mentors and mentees are in database
  
 Given I am logged in as an Administrator
 And I am on the Dashboard page

@sort_students
Scenario: sort students
  When I sort "name" ascending
  Then I should see "Max" before "Shelly"
  When I sort "name" descending
  Then I should see "Shelly" before "Max"
  When I sort "role" ascending
  Then I should see "MENTEE" before "MENTOR"
  When I sort "role" descending
  Then I should see "MENTEE" before "MENTOR"
  When I sort "company" ascending
  Then I should see "bravo" before "palmetto"
  When I sort "company" descending
  Then I should see "palmetto" before "bravo"
  When I sort "advisor_email" ascending
  Then I should see "john.moore@citadel.edu" before "mv@citadel.edu"
  When I sort "advisor_email" descending
  Then I should see "mv@citadel.edu" before "john.moore@citadel.edu"