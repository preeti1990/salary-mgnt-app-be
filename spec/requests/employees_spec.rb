require "rails_helper"

RSpec.describe "Employees", type: :request do
  it "creates a new employee" do
      employee_params = {
        full_name: "Preeti Gupta",
        job_title: "Manager",
        country: "India",
        salary: 50000,
        email: "prtjan6990@gmail.com",
        age: "35",
        active: true,
        phone_number: "1234567890",
        date_of_joining: "2020-01-01"
    }

    post "/employees", params: { employee: employee_params }

    expect(response).to have_http_status(:created)
  end
end