ActiveAdmin.register SingleSet do
  filter :workout_user_email_cont, label: "User Email Contains"
  filter :reps
  filter :weight
  filter :performed_at
end


ActiveAdmin.register SingleSet, namespace: :api do
  permit_params :reps, :weight, :performed_at, :exercise_id, :workout_id

  config.paginate = false

  controller do
    nested_belongs_to :user, :workout
    skip_before_action :verify_authenticity_token
    before_action :restrict_content_type

    private
    def restrict_content_type
      render json: {msg:  'Content-Type must be application/json'}, status: 406 unless request.content_type == 'application/json'
    end
  end
end
