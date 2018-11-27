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

exercises = {  }

User.all.each do |user|
  user.workouts.each do |workout|
    workout_start_time = rand(workout.workout_date.beginning_of_day..(workout.workout_date.end_of_day - 4.hours))
    performed_at_offset = 0
    CSV.foreach(File.join(SAMPLE_DATA, "single_sets.csv"), headers: true) do |row|
      exercise = exercises[row["Exercise"]] ||= Exercise.find_or_create_by(name: row["Exercise"])
      performed_at_offset += 1
      next unless rand < 0.5 # only have so much room in the free pg database
      SingleSet.create(workout: workout,
                       reps: row["Reps"],
                       weight: row["Weight"],
                       performed_at: workout_start_time + performed_at_offset.minutes)
      break if workout.workout_duration <= performed_at_offset
    end
  end
end
