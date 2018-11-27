ActiveAdmin.register Workout do
  filter :user_email_contains, label: "User Email Contains"
  filter :workout_date
  filter :workout_duration
end

ActiveAdmin.register Workout, namespace: :profile do
  permit_params :workout_duration, :workout_date
  belongs_to :user
  filter :workout_duration

  config.clear_action_items!
  config.paginate = false

  action_item :new do
    link_to "New Workout", new_profile_user_workout_path(current_user)
  end


  index do
    selectable_column
    column :workout_date
    column :workout_duration
    actions
  end

  form do |f|
    f.semantic_errors # shows errors on :base
    f.inputs do
      f.input :workout_duration
      f.input :workout_date, as: :datepicker,
              datepicker_options: {
                min_date: "2013-10-11",
                max_date: "+1D"
              }
    end
    f.actions         # adds the 'Submit' and 'Cancel' buttons
  end

  controller do
    def create
      @workout = Workout.new(permitted_params[:workout])
      @workout.user = current_user
      create!{ profile_user_workouts_path(current_user) }
    end
  end
end

ActiveAdmin.register Workout, namespace: :api do
  permit_params :workout_duration, :workout_date
  belongs_to :user
  # TODO: determine why activeadmin is ignoring the concern
  controller do
    skip_before_action :verify_authenticity_token
    before_action :restrict_content_type

    private
    def restrict_content_type
      render json: {msg:  'Content-Type must be application/json'}, status: 406 unless request.content_type == 'application/json'
    end
  end
end
