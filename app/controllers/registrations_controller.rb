class RegistrationsController < Devise::RegistrationsController
  def new
    @user = User.new
    respond_to do |format|
      format.html { render 'devise/registrations/new' }
    end
  end

  def create
    user = User.new(sign_up_params)
    if user.save
      token = user.generate_jwt
      respond_to do |format|
        format.html do
          flash[:success] = 'User added successfully'
          redirect_to users_path
        end
        format.json { render json: token.to_json }
      end
    else
      respond_to do |format|
        format.html do
          flash.now[:error] = 'Error: User could not be saved'
          render 'devise/registrations/new'
        end
      end
      render json: { errors: { 'email or password' => ['is invalid'] } }, status: :unprocessable_entity
    end
  end

  def sign_up_params
    params.require('user').permit(:email, :name, :password, :post_counter)
  end
end
