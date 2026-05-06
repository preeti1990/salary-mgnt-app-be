class SalaryInsights

  def initialize(country: nil)
    @country = country
  end

  def country_stats
   
    employees = Employee.where(country: @country) if @country.present?
    return empty if employees.nil?
    
    salaries = employees.pluck(:salary)
    {
      min: salaries.min,
      max: salaries.max,
      avg: salaries.sum.to_f / salaries.length
    }
  end

  def job_title_stats(job_title)
    employees = Employee.where(country: @country).where(job_title: job_title)
    return empty if employees.empty?

    salaries = employees.pluck(:salary)
    {
      avg: (salaries.sum.to_f / salaries.length).round(2)
    }
  end
  
  private

  def empty
    {
      min: 0,
      max: 0,
      avg: 0
    }
  end
end