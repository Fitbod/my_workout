ActiveAdmin.register User do
  permit_params :email, :password, :password_confirmation

  index do
    selectable_column
    id_column
    column :email
    column :current_sign_in_at
    column :sign_in_count
    column :created_at
    actions
  end

  filter :email
  filter :current_sign_in_at
  filter :sign_in_count
  filter :created_at

  form do |f|
    f.inputs do
      f.input :email
      f.input :password
      f.input :password_confirmation
    end
    f.actions
  end
end

ActiveAdmin.register User, namespace: :profile do
  filter :email
  index do
    column "User" do |user|
      link_to user.email, profile_user_workouts_path(user)
    end
  end

  show do
    panel "Workouts" do
      table_for user.workouts do
        column :workout_date
        column :workout_duration
      end
    end
  end
end

ActiveAdmin.register User, namespace: :api do
  filter :email

  controller do
    skip_before_action :verify_authenticity_token
  end
end

