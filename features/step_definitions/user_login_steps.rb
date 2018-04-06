Given /^the following users exist:$/ do |users_table|
  users_table.hashes.each do |user|
    User.create! user
  end
end

Then /^I should find the account for "(.*)"$/ do |email|
  expect(find("a#delete_user_#{User.find_by_email(email).id}_link")).not_to be_nil
end
  
Then /^I should not find the account for "(.*)"$/ do |email|
  expect(User.find_by_email(email)).to be_nil
  step "I should not see \"#{email}\""
end

And /^I expect "(.*)" to contain "(.*)"$/ do |field_name,value|
  expect(page).to have_field(field_name, with: value)
end

And /^I expect "(.*)" to be empty$/ do |field_name|
  expect(page).to have_field(field_name) do |field|
    field.value.present?
  end
end

Then /^I activate the account for "(.*)"$/ do |email|
  visit path_to("the Activation page for \"#{email}\"")
end

Then /^I reset the password for "(.*)"$/ do |email|
  visit path_to("the Reset Password page for \"#{email}\"")
end

Then /^I wind up on (.*)$/ do |path|
  expect(URI.parse(current_url).request_uri).to eq(path_to(path))
end

And /^I delete the account with "(.*)"$/ do |button|
  click_button(button)
  sleep 1
  expect(page.driver.confirm_messages).to include("Are you sure?")
  page.driver.accept_js_confirms!
end

Given /^I am logged in as a Mentor$/ do
  step "I go to the Login page"
  step "I fill in \"Email\" with \"jsmith@gmail.com\""
  step "I fill in \"Password\" with \"password\""
  step "I press \"log_in_button\""
  step "I wind up on the Mentees Report page for \"jsmith@gmail.com\""
end

Given /^I am logged in as an Administrator/ do
  step "I go to the Login page"
  step "I fill in \"Email\" with \"guru4u602@gmail.com\""
  step "I fill in \"Password\" with \"foobar\""
  step "I press \"log_in_button\""
  step "I should be on the Dashboard page"
end
