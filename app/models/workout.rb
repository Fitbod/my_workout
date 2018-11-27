class Workout < ApplicationRecord
  belongs_to :user
  has_many :single_sets
end
