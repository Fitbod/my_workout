ActiveAdmin.register Workout do
  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # permit_params :list, :of, :attributes, :on, :model
  #
  # or
  #
  # permit_params do
  #   permitted = [:permitted, :attributes]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end

end

ActiveAdmin.register Workout, namespace: :profile do
  permit_params :workout_duration, :workout_date
  belongs_to :user
  filter :workout_duration

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
  controller do
    skip_before_action :verify_authenticity_token
    before_action :restrict_content_type

    private
    def restrict_content_type
      render json: {msg:  'Content-Type must be application/json'}, status: 406 unless request.content_type == 'application/json'
    end
  end
  belongs_to :user
end
