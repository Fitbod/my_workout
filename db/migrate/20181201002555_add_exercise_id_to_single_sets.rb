class AddExerciseIdToSingleSets < ActiveRecord::Migration[5.2]
  def change
    add_reference(:single_sets, :exercise, foreign_key: true)
  end
end
