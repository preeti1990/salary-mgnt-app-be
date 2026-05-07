require "rails_helper"
RSpec.describe "Insights", type: :request do
  describe "GET /insights/country_stats" do
    before do
      Employee.create!(full_name: "Preeti Gupta", job_title: "Manager", country: "India", salary: 50000, email: "prtjan6990@gmail.com", phone_number: "1234567890", age: "35", active: true)
      Employee.create!(full_name: "Richa Gupta", job_title: "Manager", country: "India", salary: 60000, email: "richamathur@gmail.com", phone_number: "1234567895", age: "35", active: true)
      Employee.create!(full_name: "Amit Sharma", job_title: "Developer", country: "India", salary: 40000, email: "amitsharma@gmail.com", phone_number: "1234567896", age: "30", active: true)

    end

    it "returns country stats" do
      get "/insights", params: { country: "India" }
      expect(response).to have_http_status(:ok)

      response_data = JSON.parse(response.body)

      puts "Response data: #{response_data}"
      expect(response_data['min']).to eq(40000)
      expect(response_data['max']).to eq(60000)
      expect(response_data['avg']).to eq(50000)
    end

    it "returns error if country missing" do
      get "/insights"

      expect(response).to have_http_status(:bad_request)
    end
  end

  describe "GET /insights/job_title_stats" do
    before do
      Employee.create!(full_name: "Preeti Gupta", job_title: "Manager", country: "India", salary: 50000, email: "prtjan6990@gmail.com", phone_number: "1234567890", age: "35")
      Employee.create!(full_name: "Richa Gupta", job_title: "Manager", country: "India", salary: 60000, email: "richamathur@gmail.com", phone_number: "1234567895", age: "35")
      Employee.create!(full_name: "Amit Sharma", job_title: "Developer", country: "India", salary: 40000, email: "amitsharma@gmail.com", phone_number: "1234567896", age: "30")
      Employee.create!(full_name: "Suman Singh", job_title: "Manager", country: "India", salary: 55000, email: "sumansingh@gmail.com", phone_number: "1234567897", age: "40")
      Employee.create!(full_name: "Rohit Verma", job_title: "Developer", country: "India", salary: 45000, email: "rohitverma@gmail.com", phone_number: "1234567898", age: "35")
    end

    it "returns job title stats" do
      get "/insights/job_title_stats", params: { country: "India", job_title: "Manager" }
      expect(response).to have_http_status(:ok)

      response_data = JSON.parse(response.body)
      puts "Response data in job title stats: #{response_data}"
      
      expect(response_data['avg']).to eq(55000)
    end

    it "returns error if country  and job title missing" do
      get "/insights/job_title_stats"

      expect(response).to have_http_status(:bad_request)
    end

  end 
end