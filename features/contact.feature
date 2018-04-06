Feature: Get contact information for Guru4u
 
  As a Guru4u visitor
  So that I can talk to someone about Guru4u
  I want to request Contact information

Background: a vistor is on the home page
  
  Given I am on the home page
  
Scenario:  Request Contact information
  When I follow "contact_link"
  Then I should be on the Contact page