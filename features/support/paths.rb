# TL;DR: YOU SHOULD DELETE THIS FILE
#
# This file is used by web_steps.rb, which you should also delete
#
# You have been warned
include SessionsHelper

module NavigationHelpers
  # Maps a name to a path. Used by the
  #
  #   When /^I go to (.+)$/ do |page_name|
  #
  # step definition in web_steps.rb
  #
  def path_to(page_name)
    case page_name

    when /^the home\s?page$/
      '/'
    
    when /^the Create New Report page/
      '/reports/new'
      
    when /^the Edit Report page for "(.*)"$/
      edit_report_path(id: $1)
      
    when /^the Reports page for "(.*)"$/
      report_path(id: $1)
      
    when /^the Login page$/
      login_path

    when /^the Dashboard page$/
      students_path

    when /^the New Mentor Report page$/
      new_report_path

    when /^the Help page$/
      help_path

    when /^the About page$/
      about_path
      
    when /^the Contact page$/
      contact_path

    when /^the New User page$/
      new_user_path

    when /^the Manage Users page$/
      users_path
      
    when /^the Forgotten Password page$/
      new_password_reset_path
      
    when /^the Mentees Report page for "(.*)"/
      reports_path(id: Student.find_by_email($1).id)
      
    when /^the New Student page$/
        new_student_path
        
    when /^the Edit Student page$/
      edit_student_path

   when /^the Edit Student page for "(.*)"$/
      edit_student_path(Student.find_by_name($1))

    when /^the Dashboard page$/
      students_path

    when /^the Profile page for "(.*)"$/
      user_path(User.find_by_email($1))

    when /^the Edit User page for "(.*)"$/
      edit_user_path(User.find_by_email($1))

    when /^the Activation page for "(.*)"$/
      edit_account_activation_path($activation_token,email: $1)

    when /^the Reset Password page for "(.*)"$/
      edit_password_reset_path($reset_token,email: $1)

    when /^the Settings page for "(.*)"$/
      edit_user_path(User.find_by_email($1).id)
    
    when /^the Edit Mentor Report page for report "(.*)", user "(.*)"$/
      edit_report_path($1,user_id: User.find_by(email: $2).id)
      
    when /^the Mentee Reports page for Student "(.*)"$/
      report_path(Student.find_by(email: $1).id)
      
    when /^the Mentee List page for Mentor "(.*)"$/
      reports_path(id: Student.find_by(email: $1).id)
      
    # Add more mappings here.
    # Here is an example that pulls values out of the Regexp:
    #
    #   when /^(.*)'s profile page$/i
    #     user_profile_path(User.find_by_login($1))

    else
      begin
        page_name =~ /^the (.*) page$/
        path_components = $1.split(/\s+/)
        self.send(path_components.push('path').join('_').to_sym)
      rescue NoMethodError, ArgumentError
        raise "Can't find mapping from \"#{page_name}\" to a path.\n" +
          "Now, go and add a mapping in #{__FILE__}"
      end
    end
  end
end

World(NavigationHelpers)
