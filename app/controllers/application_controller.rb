class ApplicationController < ActionController::Base
    before_action :authenticate_user!
    protect_from_forgery with: :exception

  # Override Devise's after sign-in path
    def after_sign_in_path_for(resource)
      if resource.admin?
        dashboard_path
      else
        user_path(resource)
      end
    end
end
