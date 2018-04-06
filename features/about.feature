Feature: Find out about Guru4u
 
  As a Guru4u visitor
  So that I can find out about Guru4u
  I want to request About information

Background: a vistor is on the home page
  
  Given I am on the home page
  
Scenario:  Request About information
  When I follow "about_link"
  Then I should be on the About page