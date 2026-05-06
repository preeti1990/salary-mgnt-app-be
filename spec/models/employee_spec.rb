require 'rails_helper'

RSpec.describe Employee, type: :model do
  it 'is valid with all valid attributes' do
    employee = Employee.new(
    full_name:'Preeti Gupta', 
    job_title: 'Manager', 
    country: 'India', 
    salary: 50000, 
    email: 'prtjan6990@gmail.com',
    age: '35', 
    active: true, 
    phone_number: '1234567890',
    date_of_joining: '2020-01-01')

    expect(employee).to be_valid
  end

  it "To be invalid without a full name" do
    employee = Employee.new(full_name: nil)

    expect(employee).not_to be_valid
  end

  it "To be invalid without a job title" do
    employee = Employee.new(job_title: nil)

    expect(employee).not_to be_valid
  end

  it "To be invalid without a phone number" do
    employee = Employee.new(phone_number: nil)

    expect(employee).not_to be_valid
  end
end