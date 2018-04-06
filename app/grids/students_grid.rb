class StudentsGrid < BaseGrid
  include Datagrid
  #
  # Scope
  #
  
  scope do
    Student.
      joins(
        "LEFT JOIN "+
          "(SELECT "+
            "mentee_id, "+
            "MAX(CASE WHEN urgent = 't' THEN 1 ELSE 0 END) AS hu, "+
            "MAX(created_at) AS lc "+
          "FROM reports "+
          "GROUP BY mentee_id) r "+
        "ON r.mentee_id = students.id").
      select(
          "*, CASE WHEN r.hu IS NULL THEN 0 ELSE r.hu END AS has_urgent, r.lc as last_contact")  
  end
  
  #
  # Columns
  #
  column(:id, mandatory: true, class: 'center')
  column(:name, html:true, mandatory: true) do |u|
    link_to u.name, edit_student_path(:id => u.id), :id => "edit_student_#{u.id}"
  end
  column(:cwid, mandatory: true)
  column(:email, html:true, mandatory: true) do |u|
    link_to u.email, "mailto:#{u.email}"
  end
  column(:company, mandatory: true)
  column(:phone, html: true, mandatory: true) do |u|
    number_to_phone(u.phone, area_code: true)
  end
  column(:role, mandatory: true)
  column(:advisor, mandatory: true)
  column(:advisor_email, html:true, mandatory: true) do |u|
    link_to u.advisor_email, "mailto:#{u.advisor_email}"
  end
  column(:mentor_id, html: true, mandatory: true) do |u|
    u.mentor&.name
  end
  column(:last_contact, html:true, mandatory: true, order: proc {|scope| scope.order("last_contact")}) do |u|
    date = u.last_contact
    date.to_datetime.strftime("%m/%d/%Y %H:%M:%S") unless date.blank?
  end
  column(:has_urgent, header: "Urgent?", html:true, mandatory: true, class: 'center', order: proc {|scope| scope.order("has_urgent")}) do |u|
    "Yes" if u.has_urgent == 1
  end
  column(:report, html:true, mandatory: true) do |u|
    if u.role == Student::MENTEE 
      link_to "Reports", report_path(:id => u.id), :id => "mentee_report_#{u.id}"
    elsif u.role == Student::MENTOR
      link_to "Mentee Reports", reports_path(:id => u.id), :id => "mentor_reports_#{u.id}"
    end
  end
  
end