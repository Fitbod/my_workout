FactoryBot.define do
  factory :workout do
    association :user
    workout_duration 30
    workout_date Date.today
  end
end
