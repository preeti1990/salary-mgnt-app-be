require "rails_helper"

RSpec.describe "Employees", type: :request do
  describe "POST /employees" do
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

  describe "GET /employees/:id" do
    let(:employee) { Employee.create!(full_name: "Richa Gupta", job_title: "Manager", country: "India", salary: 60000, email: "richamathur@gmail.com", age: "35", active: true, phone_number: "1234567895", date_of_joining: "2020-01-03") }
    
    it "returns an employee" do
      puts "Employee ID:  in get after create is #{employee.id}"
      get "/employees/#{employee.id}"

      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body)["full_name"]).to eq("Richa Gupta")
    end

    it "returns not found for non-existent employee" do
      get "/employees/9999"

      expect(response).to have_http_status(:not_found)
    end
  end

  describe "PUT /employees/:id" do
    let(:employee) { Employee.create!(full_name: "Preeti Gupta", job_title: "Manager", country: "India", salary: 50000, email: "prtjan6990@gmail.com", age: "35", active: true, phone_number: "1234567890", date_of_joining: "2020-01-01") }
    it "updates an employee" do
      put "/employees/#{employee.id}", params: { employee: { full_name: "Preeti Sharma" } }

      expect(response).to have_http_status(:ok)
      employee.reload
      expect(employee.full_name).to eq("Preeti Sharma")
    end

    it "returns not found for non-existent employee" do
      put "/employees/9999", params: { employee: { full_name: "Preeti Sharma" } }

      expect(response).to have_http_status(:not_found)
    end

    it "returns bad request for invalid update" do
      put "/employees/#{employee.id}", params: { employee: { full_name: nil } }

      expect(response).to have_http_status(:unprocessable_content)
    end
  end

  describe "DELETE /employees/:id" do
    let(:employee) { Employee.create!(full_name: "Varsha Jon", job_title: "Sr. Manager", country: "India", salary: 70000, email: "varshajon@gmail.com", age: "37", active: true, phone_number: "1234556689", date_of_joining: "2020-01-01") }
    
    it "deletes an employee" do
      puts "Employee ID in delete after create is #{employee.id}"
      delete "/employees/#{employee.id}"
      puts "Response status in delete is #{response.status}"
      expect(response).to have_http_status(:no_content)
      expect(Employee.exists?(employee.id)).to be_falsey
    end
  end
end