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
  if !search.blank? #If a search string is passed:
    search_strings = search.split #Break the search string up into individual terms.
    search_strings.collect! {|s| s.strip} #Remove whitespace from each token.
    if search_strings.count == 1 #Don't do extra processing if only one token being searched.
      @employees = Employee.where('first_name LIKE ? OR last_name LIKE ? OR business_email LIKE ?', "#{search_strings[0]}%","#{search_strings[0]}%","#{search_strings[0]}%").order(:last_name, :first_name)
    else
      emps = search_strings.collect { |str| Employee.where('first_name LIKE ? OR last_name LIKE ? OR business_email LIKE ?', "#{str}%","#{str}%","#{str}%")}
      emps.reject!{|e| e.blank?} #Remove any search strings that returned
                                 #an empty set before intersecting results.
      @employees = emps.reduce(:&) #Intersect each set of results that returned
                                    #something and save that to employees variable.
      @employees = @employees.order(:last_name, :first_name)
    end
    if !dept_filter.blank? #If something was passed in the deptartment filter:
      @employees = @employees.where(:department => dept_filter) #filter the results
    end
  elsif !dept_filter.blank? #If search is blank but dept_filter is not:
    @employees = Employee.dept(dept_filter).order(:last_name, :first_name)#filter all employees by dept
  else
    @employees = []#Show nothing.
  end

  @employees ||= []     #Incase the search returns nil, give it an empty array.
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
