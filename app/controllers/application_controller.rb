class ApplicationController < ActionController::Base
  protect_from_forgery with: :null_session

  respond_to :json

  before_action :process_token

  skip_before_action :verify_authenticity_token

  before_action :configure_permitted_parameters, if: :devise_controller?

  private

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[name email password post_counter])
  end

  def process_token
    return unless request.headers['Authorization'].present?

    begin
      jwt_payload = JWT.decode(request.headers['Authorization'].split[1].remove('"'),
                               Rails.application.secrets.secret_key_base).first
      @current_user_id = jwt_payload['id']
    rescue JWT::ExpiredSignature, JWT::VerificationError, JWT::DecodeError
      head :unauthorized
    end
  end

  def authenticate_user!(_options = {})
    head :unauthorized unless signed_in?
  end

  def signed_in?
    @current_user_id.present?
  end

  def current_user
    @current_user ||= super || User.find(@current_user_id)
  end
end
