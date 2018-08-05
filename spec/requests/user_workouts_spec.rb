require 'rails_helper'
require 'benchmark'

def bench(title)
  puts
  puts title
  Benchmark.bm do |x|
    x.report{
      yield
    }
  end
end

RSpec.describe "UserWorkouts", type: :request do
  describe "List user_workouts" do
    before(:each) do
      @user = create(:user)
      sign_in(@user)
    end
    it "works! (now write some real specs)" do
      bench("get user_workouts") do
        get user_workouts_path(@user)
      end

      expect(response).to have_http_status(200)
    end
  end
  describe "Create user_workout" do
    before(:each) do
      @user = create(:user)
      sign_in(@user)
    end
    it "works! (now write some real specs)" do
      expect {
        bench("post user_workouts") do
          post user_workouts_path(@user)
        end
      }.to change{ Workout.count }.by(1)

      expect(response).to have_http_status(302)
    end
  end
  describe "Update user_workout" do
    before(:each) do
      @user = create(:user)
      @workout = create(:workout, user: @user)
      sign_in(@user)
    end
    it "works! (now write some real specs)" do
      expect{
      bench("update user_workout") do
        put user_workout_path(@user, @workout), {
              params: {
                workout: {
                  workout_duration: @workout.workout_duration + 1
                }
              }
            }
      end
      }.to change{ @workout.reload.workout_duration }.by(1)

      expect(response).to have_http_status(302)
    end
  end

end
