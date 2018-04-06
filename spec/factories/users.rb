FactoryBot.define do
  factory :valid_administrative_user, class: User do
    name "Admin Test User"
    email "admintestuser@gmail.com"
    phone_number "8435551234"
    password "foobar"
    password_confirmation "foobar"
    admin true
    activated true
  end
end

FactoryBot.define do
  factory :valid_user, class: User do
    name "Test User"
    email "testuser@gmail.com"
    phone_number "8435551234"
    password "foobar"
    password_confirmation "foobar"
    activated true
  end
end

FactoryBot.define do
  factory :mentor_user, class: User do
    name "Joe Mentor"
    email "joementor@gmail.com"
    phone_number "5555555555"
    password "foobar"
    password_confirmation "foobar"
    activated true
  end
end