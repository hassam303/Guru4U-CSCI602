Feature: Get Help with Guru4u
 
  As a Guru4u visitor
  So that I can understand how to use Guru4u
  I want to request Help

Background: a vistor is on the home page
  
  Given I am on the home page
  
Scenario:  Request Help
  When I follow "help_link"
  Then I should be on the Help page