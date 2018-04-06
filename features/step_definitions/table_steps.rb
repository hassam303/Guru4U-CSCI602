When /^(?:|I )sort "([^"]*)" ascending$/ do |column|
  find(:css,"th.#{column}  a.asc").click
end

When /^(?:|I )sort "([^"]*)" descending/ do |column|
  find(:css,"th.#{column}  a.desc").click
end

Then /^I should see "([^"]*)" before "([^"]*)"$/ do |e1, e2|
  page.body =~ /e1.*e2/
end

