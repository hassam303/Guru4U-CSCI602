class Student < ApplicationRecord
  has_many :mentor_reports, class_name: 'Report', foreign_key: 'mentor_id'
  has_many :mentee_reports, class_name: 'Report', foreign_key: 'mentee_id'
  has_one :mentor, class_name: 'Student', primary_key: 'mentor_id', foreign_key: 'id'
  has_many :mentees, class_name: 'Student', primary_key: 'id', foreign_key: 'mentor_id'
  attr_accessor :studentName, :studentEmail
  name_validator :name
  email_validator :email
  phone_number_validator :phone
  before_save {company.upcase!}
  before_save {role.upcase!}
  VALID_CWID_REGEX = /\A[0-9]*\z/
  validates :cwid, presence: true, length:{is: 8}, format: { with: VALID_CWID_REGEX },uniqueness: true
  MENTOR = "MENTOR"
  MENTEE = "MENTEE"
  UNASSIGNED = "UNASSIGNED"
  VALID_ROLES = [MENTOR, MENTEE, UNASSIGNED]
  validates :role, presence: true, inclusion: {in: VALID_ROLES}
  VALID_COMPANIES=
    ["alpha","bravo","charlie","delta","echo","foxtrot","golf","hotel","band","india","kilo","lima","mike",
     "november","oscar","romeo","tango","palmetto","papa","sierra","victor"].map(&:upcase)
  validates :company, presence:true, inclusion: {in: VALID_COMPANIES}
  validates_each :mentor_id do |record, attr, value|
     if (value.nil? || value == 0) && record.role == MENTEE
      record.errors.add(attr, 'must be assigned if the role is MENTEE')
    elsif !value.nil? && value != 0 && record.role != MENTEE
      record.errors.add(attr,'can only be assigned if the role is MENTEE')
    end
  end
 
  def self.all_mentees(user)
    @mentees = Array.new
    if user.admin?
      mentees = Student.all
    else
      mentor = Student.find_by(email: user.email)
      mentees = mentor.mentees unless mentor.blank?
    end
    unless mentees.blank?
      mentees.each do |student|
        @mentees.push([student.name,"#{student.name}|#{student.id}"]) 
      end
    end
    @mentees
  end
  
  def self.all_mentors()
    @mentors = Array.new
    @mentors.push([Student::UNASSIGNED,"UNASSIGNED|0"])
    self.where("role = 'MENTOR'").each do |student|
      @mentors.push([student.name,"#{student.name}|#{student.id}"])
    end 
    @mentors
  end
end 
