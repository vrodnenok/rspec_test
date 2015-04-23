class UsersController < Devise::RegistrationsController

# ::RegistrationsController

  before_filter :require_permitted_parameters

  def new
  end

  protected

  def configure_permitted_parameters
    devise_parameters_sanitizer.for(:sign_up) do |u|
      u.permit(:first_name, :last_name, :email, :dept, :role, :password, 
        :password_confirmation)
    end
    devise_parameters_sanitizer.for(:account_update) do |u|
      u.permit(:first_name, :last_name, :email, :dept, :role, 
        :password, :password_confirmation)
    end
  end
end