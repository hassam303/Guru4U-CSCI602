FactoryBot.define do
  factory :valid_report, class: Report do
    mentee_id  0
    mentor_id  0
    title "Aspiring great Student!" 
    message "George might just be the Best!"
    urgent false
    created_at Time.zone.now-20.days
    updated_at Time.zone.now-20.days
  end
end