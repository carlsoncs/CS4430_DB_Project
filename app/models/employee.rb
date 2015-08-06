class Employee < ActiveRecord::Base
  attr_accessor :password
  before_save :encrypt_password

  validates_confirmation_of :password
  validates_presence_of :password, :on => :create
  validates_presence_of :business_email
  validates_uniqueness_of :business_email


def self.authenticate(email, password)
  employee = Employee.find_by business_email: email

  if employee && employee.password_digest == BCrypt::Engine.hash_secret(password, employee.salt)
    employee
  else
    nil
  end
end

def full_name
  "#{self.first_name} #{self.last_name}"
end


private

  def encrypt_password
    if password.present?
      self.salt = BCrypt::Engine.generate_salt
      self.password_digest = BCrypt::Engine.hash_secret(password, salt)
    end
  end
end
