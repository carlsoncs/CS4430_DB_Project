class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  helper_method :current_employee



  private


  def current_employee
    @current_employee ||= Employee.find(session[:employee_id]) if session[:employee_id]
  end
end
