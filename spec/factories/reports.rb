FactoryBot.define do
  factory :student_report, class: Report  do
    mentee_id '0'
    mentor_id '0'
    title     'Some Report'
    message   'A bunch of Stuff'
    urgent    'false'
  end
end
