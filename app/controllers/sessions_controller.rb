class SessionsController < ApplicationController
  def new
  end

  def create
    employee = Employee.authenticate(params[:business_email], params[:password])
    if employee
      session[:employee_id] = employee.id
      redirect_to employee, :notice => "Logged in."
    else
      flash.now[:alert] = "Invalid password or email."
      render "new"
    end
  end

  def destroy
    session[:employee_id] = nil
    redirect_to root_path, notice: "Logged out."
  end
end
