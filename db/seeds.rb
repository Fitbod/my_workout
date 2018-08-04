# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
AdminUser.create!(email: 'admin@example.com', password: 'password', password_confirmation: 'password') if Rails.env.development?

SAMPLE_DATA = File.join("db", "sample_data")

users = {  }
CSV.foreach(File.join(SAMPLE_DATA, "user.csv"), headers: true) do |row|
  email = row["Email"]
  users[email] ||= User.create!(email: email)
end

CSV.foreach(File.join(SAMPLE_DATA, "workout.csv"), headers: true) do |row|
  Workout.create!(user: users[row["Email Address"]], workout_date: row["Workout Date"], workout_duration: row["Workout Duration"])
end
