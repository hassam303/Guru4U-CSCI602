require 'csv'

csv_text = File.read(ARGV[0])
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