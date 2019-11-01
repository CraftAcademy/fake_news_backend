class ApplicationController < ActionController::API
  include DeviseTokenAuth::Concerns::SetUserByToken

  include Pundit
  before_action :configure_permitted_parameters, if: :devise_controller?
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:nickname])
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
  end

  def user_not_authorized
    render json: {error: "These are not the articles you are looking for!"}, status: 401
  end
end
