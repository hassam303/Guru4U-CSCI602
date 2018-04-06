class Report < ApplicationRecord
  has_one :mentor, primary_key: 'mentor_id', class_name: 'Student', foreign_key: 'id'
  has_one :mentee, primary_key: 'mentee_id', class_name: 'Student', foreign_key: 'id'
end
