class UsersController < ApplicationController
  before_filter :save_login_state, only: [:new, :create]

  def new
    # Signup Form
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:notice] = 'You Signed up successfully'
      redirect_to login_path
    else
      flash[:error] = @user.errors.full_messages.to_sentence
      redirect_to signup_path
    end
  end

  def search
    @user = User.where(email: params[:val], role: 'caregiver').last
    respond_to do |format|
      format.json do
        if !@user.nil?
          render json: { care_giver: @user }
        else
          render json: { errors: 'No CareGivers found' }
        end
      end
    end
  end

  private

  def user_params
    params.require(:user).permit(:username, :email, :password, :salt, :encrypted_password, :role)
  end
end
