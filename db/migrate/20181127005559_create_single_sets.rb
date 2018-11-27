class CreateSingleSets < ActiveRecord::Migration[5.2]
  def change
    create_table :single_sets do |t|
      t.float :weight
      t.integer :reps
      t.datetime :performed_at
      t.references :workout, foreign_key: true

      t.timestamps
    end
  end
end
