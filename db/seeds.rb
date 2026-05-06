# db/seeds.rb

require "securerandom"

puts "🌱 Seeding employees..."

FIRST_NAMES_PATH = Rails.root.join("db/seeds/first_names.txt")
LAST_NAMES_PATH  = Rails.root.join("db/seeds/last_names.txt")

first_names = File.readlines(FIRST_NAMES_PATH, chomp: true)
last_names  = File.readlines(LAST_NAMES_PATH, chomp: true)

job_titles = [
  "Backend Engineer",
  "Frontend Engineer",
  "Product Manager",
  "Designer",
  "QA Engineer"
]

countries = ["India", "USA", "UK", "Germany"]

TOTAL = 10000
BATCH_SIZE = 1000

start_time = Time.now

TOTAL.times.each_slice(BATCH_SIZE).with_index do |batch, batch_index|
  rows = batch.map do |i|
    {
      full_name: "#{first_names.sample} #{last_names.sample}", # duplicates allowed ✔
      job_title: job_titles.sample,
      country: countries.sample,
      salary: rand(30_000..150_000),

      #  Unique identifier → ensures idempotency
      email: "employee_#{i}@example.com",
      age: rand(22..60),
      phone_number: "#{rand(10**9..10**10)}",
      date_of_joining: rand(1..365).days.ago.to_date,
      created_at: Time.current,
      updated_at: Time.current
    }
  end

  # ✅ upsert_all ensures:
  # - no duplicate inserts
  # - safe to re-run seeds
  Employee.upsert_all(rows, unique_by: :index_employees_on_email)

  puts "✔ Batch #{batch_index + 1} inserted"
end

puts "✅ Seeding completed in #{Time.now - start_time} seconds"