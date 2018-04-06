Given /^the following students exist:$/ do |students_table|
  students_table.hashes.each do |student|
    Student.create! student
  end
end


Then /^I should see all the students$/ do
  # Make sure that all the movies in the app are visible in the table
		Student.all.each  do |student|
			step %Q{I should see "#{student.name}"}
		end
end

Then /^I should see button "(.*)"$/ do |button|
    expect(page).to have_button(button)
end


