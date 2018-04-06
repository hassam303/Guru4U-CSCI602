Feature: Create a New Report

    As a MENTOR
    So that I can document the meeting with the MENTEE
    I want to enter a contact report    

Scenario: create a brand new report not urgent

Given I am logged in as a Mentor
And I am on the Create New Report page
When I choose "Shelly Long" from "report_mentee_select"
And I fill in "report_title_field" with "Design Pattern Advice"
And I fill in "report_message_area" with "The student wanted to know how to use Observer pattern in his project."
And I press "Submit"
Then I should see "Report for Shelly Long added successfully!"
