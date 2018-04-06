##User Jeff Perrin @ https://stackoverflow.com/questions/5394799/check-select-box-has-certain-options-with-capybara 
#Find a select box by (label) name or id and assert the given text is selected
Then /^"([^"]*)" should be selected for "([^"]*)"$/ do |selected_text, dropdown|
  expect(page).to have_select(dropdown, :selected => selected_text)
end

#Find a select box by (label) name or id and assert the expected option is present
Then /^"([^"]*)" should contain "([^"]*)"$/ do |dropdown, text|
    expect(page.has_select?(dropdown,:with_options => [text])).to eq(true)
end


##Created by Hassam Solano-Morel 
Then /^I should see the "([^"]*)" select box$/ do |selectbox|
    page.has_select?(selectbox).should == true
end

Then /^I choose "([^"]*)" from "([^"]*)"$/ do |selected_text, dropdown|
  find(:css,"##{dropdown}").find(:option,"#{selected_text}").select_option
end
