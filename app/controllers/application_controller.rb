class ApplicationController < ActionController::Base
  rescue_from CanCan::AccessDenied do |exception|
    Rails.logger.debug "Access denied on #{exception.action} #{exception.subject.inspect}"
    # ...
  end

  def authenticate!
    if request.env['HTTP_AUTHORIZATION'] =~ /^Basic/
      authenticate_or_request_with_http_basic do |username,password|
        if (resource = User.find_by_email(username)) && resource.valid_password?(password)
          sign_in :user, resource
        else
          redirect_to(new_user_session_path, status: 401)
        end
      end
    else
      authenticate_user!
    end
  end
end
