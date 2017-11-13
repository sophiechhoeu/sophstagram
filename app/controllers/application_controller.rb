class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :authenticate_user!, only: :index #devise method authentic_user
  before_action :configure_permitted_parameters, if: :devise_controller?
   protected

   def after_sign_in_path_for(resource)
    if resource.profile == nil
     edit_profile_path(profile_url)
    end
   end


   def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:username])
   end
end