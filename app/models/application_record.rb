class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  def self.email_validator(*args)
    args.each do |arg|
      class_eval("validates :#{arg}, presence: true, length: { maximum: 255 },format: { with: VALID_EMAIL_REGEX }, uniqueness: { case_sensitive: false }, on: :create")
      class_eval("validates :#{arg}, length: { maximum: 255 },format: { with: VALID_EMAIL_REGEX }, uniqueness: { case_sensitive: false }, on: :update")
      class_eval("before_save {#{arg}.downcase!}")
    end
  end
  def self.phone_number_validator(*args)
    args.each do |arg|
      class_eval("before_validation {#{arg}.gsub!(/\\D/,'')}")
      class_eval("validates :#{arg}, presence: true, length: {is: 10}")
    end
  end
  def self.name_validator(*args)
    args.each do |arg|
      class_eval("validates :#{arg},  presence: true, length: { maximum: 50 }")
    end
  end
end