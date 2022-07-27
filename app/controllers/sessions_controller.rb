class SessionsController < Devise::SessionsController
  def create
    user = User.find_by_email(params[:user][:email])
    if user&.valid_password?(params[:user][:password])
      @current_user = user
      respond_to do |format|
        format.html
        format.json { render json: @current_user, status: :ok }
        redirect_to users_path
      end
    else
      render json: { errors: { 'email or password' => ['is invalid'] } }, status: :unprocessable_entity
    end
  end

  def sign_in_params
    params.permit(:email, :password)
  end
end
