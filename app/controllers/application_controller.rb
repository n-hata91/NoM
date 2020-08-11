class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :level, :language, :introduction, :image_id, :current_sign_in_at])
    devise_parameter_sanitizer.permit(:sign_in, keys: [:current_sign_in_at])
  end
end
