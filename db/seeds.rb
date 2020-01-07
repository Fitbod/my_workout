# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
unless AdminUser.where(email: "admin@example.com").first
  AdminUser.create!(email: 'admin@example.com',
                    password: Rails.application.credentials.admin_password,
                    password_confirmation: Rails.application.credentials.admin_password)
end

SAMPLE_DATA = File.join("db", "sample_data")

users = {  }
exercises = {  }

CSV.foreach(File.join(SAMPLE_DATA, "user.csv"), headers: true) do |row|
  email = row["Email"]
  unless User.where(email: email).first
    users[email] ||= User.create!(email: email,
                                  password: Rails.application.credentials.default_password,
                                  password_confirmation: Rails.application.credentials.default_password)
    CSV.foreach(File.join(SAMPLE_DATA, "workout.csv"), headers: true) do |row|
      Workout.create!(user: users[row["Email Address"]], workout_date: row["Workout Date"], workout_duration: row["Workout Duration"])
    end
    user.workouts.each do |workout|
      workout_start_time = rand(workout.workout_date.beginning_of_day..(workout.workout_date.end_of_day - 4.hours))
      performed_at_offset = 0
      CSV.foreach(File.join(SAMPLE_DATA, "single_sets.csv"), headers: true) do |row|
        exercise = exercises[row["Exercise"]] ||= Exercise.find_or_create_by(name: row["Exercise"])
        performed_at_offset += 1
        next unless rand < 0.5 # only have so much room in the free pg database
        SingleSet.create(workout: workout,
                         exercise: exercise,
                         reps: row["Reps"],
                         weight: row["Weight"],
                         performed_at: workout_start_time + performed_at_offset.minutes)
        break if workout.workout_duration <= performed_at_offset
      end
    end
  end
end




user7 = User.where(email: "user7@fitbod.me").first ||
        User.create!(email: "user7@fitbod.me",
                     password: Rails.application.credentials.default_password,
                     password_confirmation: Rails.application.credentials.default_password)
workouts = {  }
performed_at_offset = nil
workout_start_time = nil
CSV.foreach(File.join(SAMPLE_DATA, "actual.csv"), headers: true) do |row|
  unless workouts[row["workoutId"]]
    workout = workouts[row["workoutId"]] = Workout.create!(user: user7, workout_date: row["workoutDate"])
    workout_start_time = rand(workout.workout_date.beginning_of_day..(workout.workout_date.end_of_day - 4.hours))
    performed_at_offset = 0
  end
  exercise = exercises[row["exerciseName"]] ||= Exercise.find_or_create_by(name: row["exerciseName"])
  performed_at_offset += 1
  SingleSet.create(workout: workout,
                   exercise: exercise,
                   reps: row["reps"],
                   weight: row["weight"],
                   performed_at: workout_start_time + performed_at_offset.minutes)
end
