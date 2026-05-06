class Employee < ApplicationRecord
    validates :full_name, :job_title, :phone_number, :email, :salary, :age, presence: true
end
