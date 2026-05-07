class SalaryInsights
  attr_accessor :active_employees

  def initialize(country: nil)
    @active_employees = active_employees
    @country = country
  end

  def country_stats
    return empty if @active_employees.nil?
    employees = @active_employees.where(country: @country) if @country.present?
    return empty if employees.count == 0

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

  def active_employees
    @active_employees = Employee.where(active: true)
  end
end