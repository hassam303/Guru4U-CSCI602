FactoryBot.define do
  factory :student, class: Student do
    name 'John Doe'
    cwid '12348765'
    email 'johndoe@gmail.com'
    phone '5555555555'
    company 'BRAVO'
    role Student::MENTOR
    advisor 'Michael P. Verdicchio'
    advisor_email 'mv@citadel.edu'
  end
end

FactoryBot.define do
  factory :mentor_student, class: Student do
    name 'Joe Mentor'
    cwid '12348765'
    email 'joementor@gmail.com'
    phone '5555555555'
    company 'BRAVO'
    role Student::MENTOR
    advisor 'Michael P. Verdicchio'
    advisor_email 'mv@citadel.edu'
  end
end

FactoryBot.define do
  factory :mentee_student, class: Student do
    name 'Joe Mentee'
    cwid '09090909'
    email 'joementee@gmail.com'
    phone '5555555555'
    company 'BRAVO'
    role Student::MENTEE
    mentor_id '0'
    advisor 'Michael P. Verdicchio'
    advisor_email 'mv@citadel.edu'
  end
end