class RegistrationsController < Devise::RegistrationsController
  def new
    @user = User.new
    respond_to do |format|
      format.html { render 'devise/registrations/new' }
    end
  end

  def create
    user = User.new(sign_up_params)
    p user
    if user.save!
      token = user.generate_jwt
      respond_to do |format|
        format.html
        format.json { render json: token.to_json }
      end
    else
      render json: { errors: { 'email or password' => ['is invalid'] } }, status: :unprocessable_entity
    end
  end

  def sign_up_params
    params.permit(:email, :name, :password, :post_counter)
  end
end
