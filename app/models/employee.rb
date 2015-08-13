class Employee < ActiveRecord::Base
  attr_accessor :password
  before_save :encrypt_password

  validates_confirmation_of :password
  validates_presence_of :password, :on => :create
  validates_presence_of :business_email
  validates_uniqueness_of :business_email

  scope :dept, ->(department) {where :department => department}

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

def self.search(search = nil, dept_filter = nil)
  if !search.blank?
    search_strings = search.split #Break the search string up into individual terms.
    search_strings2 = search_strings.collect {|s| s.strip} #Remove whitespace
    if search_strings2.count == 1 #Don't do extra processing if only one string being searched.
      @employees = Employee.where('first_name LIKE ? OR last_name LIKE ? OR business_email LIKE ?', "%#{search_strings[0]}%","%#{search_strings[0]}%","%#{search_strings[0]}%")
    else
      emps = search_strings2.collect { |str| Employee.where('first_name LIKE ? OR last_name LIKE ? OR business_email LIKE ?', "%#{str}%","%#{str}%","%#{str}%")}

      emps2 = emps.reject{|e| e.blank?} #Remove any search strings that returned
                                        #an empty set.
      @employees = emps2.reduce(:&) #Intersect each set of results that returned
                                    #something and save that to employees variable.
    end
  elsif dept_filter
    @employees = Employee.dept(dept_filter)
  else
    @employees = []
  end

  if dept_filter && !@employees.nil?
    @employees = @employees.where(department: dept_filter)
  end
  @employees ||= []     #Incase the result search with department is nil
end

def self.unique_departments
  Employee.uniq.pluck(:department)
end

private

  def encrypt_password
    if password.present?
      self.salt = BCrypt::Engine.generate_salt
      self.password_digest = BCrypt::Engine.hash_secret(password, salt)
    end
  end
end
