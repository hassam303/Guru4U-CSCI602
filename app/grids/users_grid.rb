class UsersGrid < BaseGrid
  include Datagrid
  #
  # Scope
  #
  
  scope do
    User
  end

  #
  # Columns
  #

  column(:id, mandatory: true, class: 'center')
  column(:email, html:true, mandatory: true) do |u|
    link_to u.email, "mailto:#{u.email}"
  end
  column(:gravatar, html:true, mandatory: true, class: 'center') do |u|
    gravatar_for(u,30)
  end
  column(:name, html: true, mandatory: true) do |u|
    link_to u.name, edit_user_path(u.id), id: "edit_user_#{u.id}_link"
  end
  column(:phone_number, html: true, mandatory: true) do |u|
    number_to_phone(u.phone_number, area_code: true)
  end
  column(:admin, header: 'Admin?', mandatory: true, class: 'center') do
    admin? ? "Yes" : "No"
  end

  column(:disabled, header: 'Disabled?', mandatory: true, class: 'center') do
    disabled? ? "Yes" : "No"
  end

  column(:force_password_reset, header: 'Reset?',  mandatory: true, class: 'center') do
    force_password_reset? ? "Yes" : "No"
  end

  column(:activated, header: 'Activated?', mandatory: true, class: 'center') do
    activated? ? "Yes" : "No"
  end
  
  column(:consecutive_failed_login_attempts, header: "Failures", mandatory: true, class: 'center')
end