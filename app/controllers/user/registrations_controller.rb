class User::RegistrationsController < Devise::RegistrationsController
  before_action :configure_permitted_parameters

  protected
 
  def configure_permitted_parameters
  	devise_parameter_sanitizer.permit(:sign_up, keys: [:data_processing_confirmation])
  end
end
