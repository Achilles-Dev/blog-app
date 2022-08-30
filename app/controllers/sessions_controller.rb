class SessionsController < Devise::SessionsController
  def new
    @user = User.new
    respond_to do |format|
      format.html { render 'devise/sessions/new' }
    end
  end

  def create
    user = User.find_by_email(params[:user][:email])
    if user&.valid_password?(params[:user][:password])
      @current_user = user
      respond_to do |format|
        format.html do
          flash[:success] = 'User added successfully'
          redirect_to users_path
        end
        format.json { render json: @current_user, status: :ok }
      end
    else
      respond_to do |format|
        format.html do
          flash.now[:error] = 'Error: User could not be saved'
          render :new
        end
      end
      render json: { errors: { 'email or password' => ['is invalid'] } }, status: :unprocessable_entity
    end
  end

  def sign_in_params
    params.require('user').permit(:email, :password)
  end
end
