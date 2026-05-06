class CreateEmployees < ActiveRecord::Migration[7.2]
  def change
    create_table :employees do |t|
      t.string :full_name
      t.string :job_title
      t.string :country
      t.integer :salary
      t.string :email
      t.string :age
      t.boolean :active
      t.string :phone_number
      t.date :date_of_joining

      t.timestamps
    end
  end
end
