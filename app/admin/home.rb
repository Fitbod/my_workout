ActiveAdmin.register_page "Home", namespace: false do
  content do
    h1 do
      "Welcome"
    end
    a "README", href: "https://github.com/sideshowbandana/my_workout#my-workout", target: :blank
  end
  controller do
    skip_before_action :authenticate_active_admin_user
  end
end
