RSpec.describe "SalaryInsights", type: :service do
    before do
      Employee.create!(full_name: "Preeti Gupta", job_title: "Manager", country: "India", salary: 50000, email: "prtjan6990@gmail.com", age: "35", active: true, phone_number: "1234567890", date_of_joining: "2020-01-01")
      Employee.create!(full_name: "Richa Gupta", job_title: "Manager", country: "India", salary: 60000, email: "richamathur@gmail.com", age: "35", active: true, phone_number: "1234567895", date_of_joining: "2020-01-03")
      Employee.create!(full_name: "Amit Sharma", job_title: "Developer", country: "India", salary: 40000, email: "amitsharma@gmail.com", age: "30", active: true, phone_number: "1234567896", date_of_joining: "2020-01-04")
    end

    it "returns country stats" do
      result = SalaryInsights.new(country: "India").country_stats
      expect(result[:min]).to eq(40000)
      expect(result[:max]).to eq(60000)
      expect(result[:avg]).to eq(50000)
    end

    it "returns job title stats" do
      result = SalaryInsights.new(country: "India").job_title_stats("Manager")
      expect(result[:avg]).to eq(55000)
    end

end