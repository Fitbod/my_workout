class CreateWorkouts < ActiveRecord::Migration[5.2]
  def change
    create_table :workouts do |t|
      t.references :user, foreign_key: true
      t.datetime :workout_date
      t.integer :workout_duration

      t.timestamps
    end
  end
end
