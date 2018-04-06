require 'csv'

csv_text = File.read('db/administrators.csv')
csv = CSV.parse(csv_text, :headers => true, :encoding => 'ISO-8859-1')
csv.each do |row|
  t = User.new
  t.name = row['name']
  t.email = row['email']
  t.phone_number = row['phone_number']
  t.admin = row['admin'] == "1"
  t.password = row['email']
  t.password_confirmation = row['email']
  t.force_password_reset = true
  t.activated = true
  t.save!
end

User.create!(name:  "Guru4u Administrator",
             email: "guru4u602@gmail.com",
             phone_number: "8435550000",
             password:              "foobar",
             password_confirmation: "foobar",
             admin: true,
             activated: true,
             activated_at: Time.zone.now)

johnny_user = User.create!(name:  "Johnny Smith",
             email: "jsmith@gmail.com",
             phone_number: "8435550001",
             password:              "password",
             password_confirmation: "password",
             activated: true,
             activated_at: Time.zone.now)
               
shelly_user = User.create!(name:  "Shelly Long",
             email: "shelly@gmail.com",
             phone_number: "8435550002",
             password:              "password",
             password_confirmation: "password",
             activated: true,
             activated_at: Time.zone.now)
               
max_user = User.create!(name:  "Max Headroom",
             email: "max@gmail.com",
             phone_number: "8435550003",
             password:              "password",
             password_confirmation: "password",
             activated: true,
             activated_at: Time.zone.now)
               
george_user = User.create!(name:  "George Stephanopolis",
             email: "george@gmail.com",
             phone_number: "8435550004",
             password:              "password",
             password_confirmation: "password",
             activated: true,
             activated_at: Time.zone.now)
               
mike_user = User.create!(name:  "Mike Tyson",
             email: "mike@gmail.com",
             phone_number: "8435550005",
             password:              "password",
             password_confirmation: "password",
             activated: true,
             activated_at: Time.zone.now)
               
sarah_user = User.create!(name:  "Sarah Bernhardt",
             email: "sarah@gmail.com",
             phone_number: "8435550006",
             password:              "password",
             password_confirmation: "password",
             activated: true,
             activated_at: Time.zone.now)
               
 99.times do |n|
  name  = Faker::Name.name
  email = "example-#{n+1}@gmail.com"
  password = "password"
  User.create!(name:  name,
               email: email,
               phone_number: "843555"+("%04d" % (n+7)),
               password:              password,
               password_confirmation: password,
               activated: true,
               activated_at: Time.zone.now)
end

drmoore_email = "john.moore@citadel.edu"
drmoore = User.where("email=?",drmoore_email).first.name

johnny = Student.create!(
             cwid: "71419940",
             name:  johnny_user.name,
             email: johnny_user.email,
             phone: johnny_user.phone_number,
             company: "FOXTROT",
             role: Student::MENTOR,
             advisor_email: drmoore_email,
             advisor: drmoore,
             created_at: Time.zone.now,
             updated_at: Time.zone.now)

drbanik_email = "shankar.banik@citadel.edu"
drbanik = User.where("email=?",drbanik_email).first.name

mike = Student.create!(
             cwid: "87674325",
             name:  mike_user.name,
             email: mike_user.email,
             phone: mike_user.phone_number,
             company: "BRAVO",
             role: Student::MENTOR,
             advisor_email: drbanik_email,
             advisor: drbanik,
             created_at: Time.zone.now,
             updated_at: Time.zone.now)

drv_email =  "mv@citadel.edu"
drv = User.where("email=?",drv_email).first.name
             
shelly = Student.create!(
             cwid: "12345678",
             name:  shelly_user.name,
             email: shelly_user.email,
             phone: shelly_user.phone_number,
             company: "BRAVO",
             role: Student::MENTEE,
             advisor_email: drv_email,
             advisor: drv,
             mentor_id: johnny.id,
             created_at: Time.zone.now,
             updated_at: Time.zone.now)

drchen_email = "mei.chen@citadel.edu"
drchen = User.where("email=?",drchen_email).first.name

max = Student.create!(
             cwid: "87654321",\
             name:  max_user.name,
             email: max_user.email,
             phone: max_user.phone_number,
             company: "PALMETTO",
             role: Student::UNASSIGNED,
             advisor_email: drchen_email,
             advisor: drchen,
             created_at: Time.zone.now,
             updated_at: Time.zone.now)
             
drjoshi_email = "djoshi@citadel.edu"
drjoshi = User.where("email=?",drjoshi_email).first.name

george = Student.create!(
             cwid: "87654325",
             name:  george_user.name,
             email: george_user.email,
             phone: george_user.phone_number,
             company: "PALMETTO",
             role: Student::MENTEE,
             advisor_email: drjoshi_email,
             advisor: drjoshi,
             mentor_id: johnny.id,
             created_at: Time.zone.now,
             updated_at: Time.zone.now)

sarah = Student.create!(
             cwid: "87654335",
             name:  sarah_user.name,
             email: sarah_user.email,
             phone: sarah_user.phone_number,
             company: "PALMETTO",
             role: Student::MENTEE,
             advisor_email: drjoshi_email,
             advisor: drjoshi,
             mentor_id: mike.id,
             created_at: Time.zone.now,
             updated_at: Time.zone.now)

Report.create!(mentee_id: shelly.id,
               mentor_id: johnny.id,
              title: "Trouble Student!", 
              message: "Shelly is just the WORST!",
              urgent: true,
              created_at: Time.zone.now,
              updated_at: Time.zone.now)
              
Report.create!(mentee_id: shelly.id,
              mentor_id: johnny.id,
              title: "Potential Trouble Student!", 
              message: "Shelly is worrying me.",
              urgent: false,
              created_at: Time.zone.now-30.days,
              updated_at: Time.zone.now-30.days)
              
Report.create!(mentee_id: george.id,
              mentor_id: johnny.id,
              title: "Great Student!", 
              message: "George is just the Best!",
              urgent: false,
              created_at: Time.zone.now-10.days,
              updated_at: Time.zone.now-10.days)
              
Report.create!(mentee_id: george.id,
              mentor_id: johnny.id,
              title: "Aspiring great Student!", 
              message: "George might just be the Best!",
              urgent: false,
              created_at: Time.zone.now-20.days,
              updated_at: Time.zone.now-20.days)
