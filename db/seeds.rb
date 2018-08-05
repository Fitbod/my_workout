# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
DEFAULT_PASSWORD=
  AdminUser.create!(email: 'admin@example.com',
                    password: Rails.application.credentials.admin_password,
                    password_confirmation: Rails.application.credentials.admin_password)

SAMPLE_DATA = File.join("db", "sample_data")

users = {  }
CSV.foreach(File.join(SAMPLE_DATA, "user.csv"), headers: true) do |row|
  email = row["Email"]
  users[email] ||=
    User.create!(email: email,
                 password: Rails.application.credentials.default_password,
                 password_confirmation: Rails.application.credentials.default_password)
end

CSV.foreach(File.join(SAMPLE_DATA, "workout.csv"), headers: true) do |row|
  Workout.create!(user: users[row["Email Address"]], workout_date: row["Workout Date"], workout_duration: row["Workout Duration"])
end
