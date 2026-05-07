class EmployeesController < ApplicationController
  def create
    emp = Employee.create!(employee_params.merge!(active: true))
    render json: emp, status: :created
  end

  def index
    emps = Employee.where(country: params[:country])
    render json: emps, status: :ok
  end

  def show
    emp = Employee.find(params[:id].to_i)
    render json: emp, status: :ok
  end
  
  def update
    emp = Employee.find(params[:id].to_i)
    return json response({ error: "Employee not found" }, status: :not_found) unless emp
    emp.update!(employee_params)
    render json: emp, status: :ok
  end

  def destroy
    emp = Employee.find(params[:id].to_i)
    return json response({ error: "Employee not found" }, status: :not_found) unless emp
    emp.destroy
    head :no_content
  end

  private

  def employee_params
    params.require(:employee).permit(:full_name, :job_title, :country, :salary, :email, :age, :phone_number, :date_of_joining)
  end
end
